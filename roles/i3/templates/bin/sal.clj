#!/usr/bin/env bb
(ns sal
  (:require [cheshire.core :as json]
            [clojure.java.io :as io]
            [clojure.string :as string]
            [babashka.curl :as curl]
            [clojure.java.shell :as shell]
            [clojure.data.csv :as csv]))

;; Salary part
(def sal (-> (str (System/getProperty "user.home") "/sal.txt")
             io/file
             slurp
             string/trim
             Integer/parseInt))

(defn get-ex-rate [from to]
  (let [url (format "https://api.exchangerate.host/convert?from=%s&to=%s" from to)]
    (get-in (json/parse-string (:body (curl/get url))
                               true)
            [:info :rate])))

(def USD-RUB (get-ex-rate "USD" "RUB"))

; Output

(println (format "$%s" (-> sal (/ USD-RUB) Math/round)))

