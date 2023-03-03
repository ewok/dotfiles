#!/usr/bin/env bb
(ns b-status
  (:require
            [clojure.java.shell :as shell]
            [clojure.data.csv :as csv]))

;; Budget part

(def journal-file "~/share/Fin/current.journal")
(def today (java.time.LocalDate/now))
(def formatter (java.time.format.DateTimeFormatter/ofPattern "yyyy-MM-dd"))
(def next-month-first-day (-> today
                              (.plusMonths 1)
                              (.withDayOfMonth 1)))
(def current-month (.format today formatter))
(def next-month (.format next-month-first-day formatter))

(def exp-inc (csv/read-csv (:out (shell/sh "hledger" "-f" journal-file
                                           "-s" "bal" "--budget"
                                           "-E"
                                           "^exp" "^inc"
                                           "-b" current-month "-e" next-month
                                           "-M" "-1"
                                           "-X" "USD"
                                           "--no-total"
                                           "--real"
                                           "--layout=bare" "-O" "csv"))))

(def asset (csv/read-csv (:out (shell/sh "hledger" "-f" journal-file
                                         "-s" "bal" "--budget"
                                         "^assets:cash"
                                         "-2"
                                         "-e" next-month
                                         "-X" "USD"
                                         "--no-total"
                                         "--layout=bare" "-O" "csv"))))

(defn get-val [table id index]
  (first (filter not-empty  (for [e table]
                              (if (= 0 (compare (get e 0) id))
                                (get e index)
                                nil)))))

(def expenses (Float/parseFloat (get-val exp-inc "expenses" 2)))
(def received-revenue (* -1 (Float/parseFloat (get-val exp-inc "income" 2))))
(def planned-expenses (Float/parseFloat (get-val exp-inc "expenses" 3)))
(def planned-revenue (* -1 (Float/parseFloat (get-val exp-inc "income" 3))))
(def current-cash (Float/parseFloat (get-val asset "assets:cash" 2)))
(def money
  (+ current-cash planned-revenue
     (- planned-expenses)
     (- received-revenue)
     (if (<= expenses planned-expenses) expenses planned-expenses)))

; Output

(println (format "B:$%.0f e:$%.0f($%.0f)"  money expenses planned-expenses))

