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

      scope.primarySplit = (transaction) ->
        (s for s in transaction.splits when s.account_id == scope.account.id)[0]

      scope.secondarySplits = (transaction) ->
        (s for s in transaction.splits when s.account_id != scope.account.id)

      scope.categoryToDisplay = (transaction) ->
        if transaction.splits.length > 2
          return "Splits"
        secondaries = scope.secondarySplits(transaction)
        return scope.accountsById[secondaries[0].account_id].name

      scope.amountToDisplay = (transaction) ->
        return scope.primarySplit(transaction).amount

      scope.statusToDisplay = (transaction) ->
        return scope.primarySplit(transaction).reconciled_status
]
