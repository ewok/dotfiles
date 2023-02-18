#!/usr/bin/env bb
(ns sal
  (:require [cheshire.core :as json]
            [clojure.java.io :as io]
            [clojure.string :as string]
            [babashka.curl :as curl]))

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
(def USD-KGS (get-ex-rate "USD" "KGS"))
(def RUB-KGS (get-ex-rate "RUB" "KGS"))

(println (format "U:%s" (-> sal (/ USD-RUB) Math/round))
         (format "U2:%s" (-> sal (* RUB-KGS) (/ USD-KGS) Math/round)))

