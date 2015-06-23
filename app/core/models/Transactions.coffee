angular.module("buckit.core").factory "Transactions", [
  "Model"
  (Model) ->
    m = new Model("Accounts", "/api/transactions/:id")

    m.queryByAccount = (accountId) ->
      if not accountId
        throw new Error("accountId must be defined")
      m.query
        q:
          filters: [
            name: "splits__account_id"
            op: "any"
            val: accountId
          ]

    return m
]
