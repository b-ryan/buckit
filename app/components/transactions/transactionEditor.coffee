angular.module("buckit").directive "transactionEditor", [
  "componentUrl"
  "Transactions"
  "Accounts"
  (componentUrl, Transactions, Accounts) ->
    restrict: "E"
    templateUrl: componentUrl("transactions/transactionEditor.html")
    scope:
      transactionId: "="
      accountId: "="
    link: (scope, elem, attr) ->
      scope.transaction = null
      scope.account = null

      Transactions.get({id: scope.transactionId}).then (transaction) ->
        scope.transaction = transaction
      , (error) ->
        alert error

      Accounts.get({id: scope.accountId}).then (account) ->
        scope.account = account
      , (error) ->
        alert error
]
