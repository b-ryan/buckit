angular.module("buckit.components").directive "ledger", [
  "componentUrl"
  "Accounts"
  "Transactions"
  (componentUrl, Accounts, Transactions) ->
    restrict: "E"
    templateUrl: componentUrl("ledger/ledger.html")
    scope:
      accountId: "="
    link: (scope, elem, attr) ->
      scope.account = null
      scope.accountsById = {}
      scope.transactions = []

      Accounts.query().then (accounts) ->
        for a in accounts
          scope.accountsById[a.id] = a
      , (error) ->
        alert error

      Accounts.get({id: scope.accountId}).then (account) ->
        scope.account = account
        fetchTransactions()
      , (error) ->
        alert error

      fetchTransactions = ->
        Transactions.queryByAccount(scope.account.id).then (transactions) ->
          scope.transactions = transactions
        , (error) ->
          alert error

    controller: [
      "$scope"
      ($scope) ->
        @getActiveAccount = ->
          $scope.account

        @getAccountById = (id) ->
          $scope.accountsById[id]
    ]
]
