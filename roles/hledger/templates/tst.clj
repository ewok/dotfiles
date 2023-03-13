(require '[babashka.curl :as http])

(def api-url "https://api.exchangerate.host/timeseries")

(defn get-exchange-rates [base-currency start-date end-date]
  (let [url (str api-url "?base=" base-currency "&start_date=" start-date "&end_date=" end-date)]
    (:body (http/get url {:as :json}))))

(def exchange-rates (get-exchange-rates "USD" "2022-01-01" "2022-01-31"))

(println exchange-rates)
