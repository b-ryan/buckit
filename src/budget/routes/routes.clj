(ns budget.routes.routes
  (:require [ring.util.response :refer [response
                                        resource-response]]
            [ring.middleware.json :refer [wrap-json-body
                                          wrap-json-response]]
            [compojure.core :refer :all]
            [compojure.handler :as handler]
            [compojure.route :as route]
            [budget.db :as db]
            [korma.core :refer :all]
            [budget.routes.accounts]
            [budget.routes.transactions]))

(defroutes transactions-routes

    (GET "/" []
      (-> (select db/transactions)
          (response))))

(defroutes app-routes
  (GET "/" []
    (resource-response "/html/index.html" {:root "public"}))

  (context "/accounts" [] budget.routes.accounts/accounts)
  (context "/transactions" [] budget.routes.transactions/transactions)

  (route/resources "/")
  (route/not-found "Not Found"))

(def app
  (-> (handler/site app-routes)
      (wrap-json-body {:keywords? true})
      (wrap-json-response)))
