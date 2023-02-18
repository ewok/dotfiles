#!/usr/bin/env bb

(require '[clojure.java.shell :as shell])
(require '[clojure.data.csv :as csv])

(def journal-file "~/share/Fin/current.journal")

(def today (java.time.LocalDate/now))

(def next-month-first-day (-> today
              (.plusMonths 1)
              (.withDayOfMonth 1)))

(def day (-> today (.getDayOfMonth)))
(def days_in_month (-> today (.lengthOfMonth)))

(def formatter (java.time.format.DateTimeFormatter/ofPattern "yyyy-MM-dd"))

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
; Current Cash = assets -> current

(defn get-val [table id index]
  (first (filter not-empty  (for [e table]
                              (if (= 0 (compare (get e 0) id))
                                (get e index)
                                nil)))))

; M = Current Cash + Planned Revenue - Planned Expenses - Received Income + (Expenses if <= Planned Expenses)
; Planned Revenue = income -> budget
; Reveived Income = income -> current
; Planned Expenses = expenses -> budget
; Expenses = expenses -> current

(def received-revenue (* -1 (Float/parseFloat (get-val exp-inc "income" 2))))
(def planned-revenue (* -1 (Float/parseFloat (get-val exp-inc "income" 3))))
(def expenses (Float/parseFloat (get-val exp-inc "expenses" 2)))
(def planned-expenses (Float/parseFloat (get-val exp-inc "expenses" 3)))
(def current-cash (Float/parseFloat (get-val asset "assets:cash" 2)))

; money = Current Cash + Planned Revenue - Planned Expenses - Received Income + (Expenses if <= Planned Expenses)
(def money
  (+ current-cash planned-revenue
     (- planned-expenses)
     (- received-revenue)
     (if (<= expenses planned-expenses) expenses planned-expenses)))

; Add color to the output
(defn color [color text]
  (str "\033[" color "m" text "\033[0m"))

; function to print red if value is negative
(defn print-red-if-negative [value text]
  (if (< value 0)
    (print (color "31" (format text value)))
    (print (format text value))))

(println (format "Today is day %s of %s days, which is %.2f%%\n" day days_in_month (float (* 100 (/ day days_in_month)))))

(print-red-if-negative money "Money:                    %.2f USD\n")
(print-red-if-negative (+ current-cash planned-revenue (- received-revenue)) "Just money + income:      %.2f USD\n")
(print-red-if-negative current-cash "Just money(end of month): %.2f USD\n\n")

(print-red-if-negative planned-revenue "Planned income:           %.2f")
(print-red-if-negative received-revenue "  Received income:          %.2f\n")

(print-red-if-negative planned-expenses "Planned expenses:         %.2f")
(print-red-if-negative expenses "  Expenses:                 %.2f\n\n")
