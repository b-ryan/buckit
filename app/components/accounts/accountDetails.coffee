angular.module("buckit").directive 'accountDetails', [
  "componentUrl"
  "$stateParams"
  "Accounts"
  "Transactions"
  (componentUrl, $stateParams, Accounts, Transactions) ->
    restrict: "E"
    templateUrl: componentUrl("accounts/accountDetails.html")
    link: (scope, elem, attr) ->
      scope.account = null
      scope.accountsById = {}
      scope.transactions = []

      Accounts.get({id: $stateParams.id}).then (account) ->
        scope.account = account
        fetchTransactions()
      , (error) ->
        alert error

      Accounts.query().then (accounts) ->
        for a in accounts
          scope.accountsById[a.id] = a
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
