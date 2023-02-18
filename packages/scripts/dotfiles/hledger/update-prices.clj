#!/usr/bin/env bb
(ns get-ex
  (:require [cheshire.core :as json]
            [babashka.curl :as curl]))

(def end (.format (java.text.SimpleDateFormat. "yyyy-MM-dd") (java.util.Date.)))
(def year (Integer/parseInt (subs end 0 4)))
(def start (str year "-01-01"))

(def url-base (format "https://api.exchangerate.host/timeseries?start_date=%s&end_date=%s" start end))

(def url (str url-base "&base=%s&symbols=%s"))
(def url-crypto (str url-base "&base=%s&symbols=%s&source=crypto"))

(defn get-ex-rate [from to]
  (get-in (json/parse-string (:body (curl/get (format url from to)))
                             true)
          [:rates]))

(def ex (get-ex-rate "USD" "RUB,KGS,AED,PHP,EUR"))

(def rates (for [i ex] (let [date (name (key i))] (for [y (val i)]
                                                    (let [currency (name (key y))
                                                          rate (val y)]
                                                      (format "P %s USD %s %s" date rate currency))))))

(spit
 (format "%s/share/Fin/prices-%s" (System/getProperty "user.home") year)
 (->> rates
      flatten
      vec
      sort
      (clojure.string/join "\n")))
