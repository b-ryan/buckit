(ns budget.db
  (:require [korma.core :as k]
            [korma.db :as kdb]))

(kdb/defdb budget (kdb/postgres {:db "budget"
                                 :user "budget"
                                 :password "password"
                                 :host "127.0.0.1"}))

(declare accounts transactions)

(k/defentity accounts
  (k/database budget))

(k/defentity transactions
  (k/database budget)
  (k/entity-fields :date :status)
  (k/belongs-to accounts))

(defn get-all [tbl]
  (k/select tbl))

(defn get-by-id [tbl id]
  (-> (k/select tbl
        (k/where {:id id}))
      (first)))

(defn create [tbl item]
  (k/insert tbl
    (k/values item)))

(defn update [tbl item]
  (k/update tbl
    (k/set-fields item)
    (k/where {:id (get item :id)})))

(defn delete [tbl item]
  (k/delete tbl
    (k/where {:id (get item :id)})))
