(ns budget.routes.transactions
  (:require [ring.util.response :refer [response]]
            [compojure.core :refer :all]
            [budget.db :as db]
            [korma.core :refer :all]))

(defroutes transactions

    (GET "/" []
      (response
        (db/get-all db/transactions)))

    (GET "/:id" [id]
      (response
        (db/get-by-id db/transactions (Integer. id))))

    (POST "/" {transaction :body}
      (response
        (db/create db/transactions transaction)))

    (PUT "/" {transaction :body}
      (response
        (db/update db/transactions transaction)))

    (DELETE "/" {transaction :body}
      (db/delete db/transactions transaction)
      (response nil)))
