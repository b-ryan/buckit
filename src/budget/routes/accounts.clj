(ns budget.routes.accounts
  (:require [ring.util.response :refer [response]]
            [compojure.core :refer :all]
            [budget.db :as db]))

(defroutes accounts

    (GET "/" []
      (response
        (db/get-all db/accounts)))

    (GET "/:id" [id]
      (response
        (db/get-by-id db/accounts (Integer. id))))

    (POST "/" {account :body}
      (response
        (db/create db/accounts account)))

    (PUT "/" {account :body}
      (response
        (db/update db/accounts account)))

    (DELETE "/" {account :body}
      (db/delete db/accounts account)
      (response nil)))
