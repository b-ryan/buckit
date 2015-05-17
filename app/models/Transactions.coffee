angular.module("buckit").factory "Transactions", [
  "Model"
  (Model) ->
    m = new Model("Accounts", "/api/transactions/:id")

    m.queryByAccount = (accountId) ->
      m.query
        q:
          filters: [
            name: "splits__account_id"
            op: "any"
            val: accountId
          ]

    return m
]
