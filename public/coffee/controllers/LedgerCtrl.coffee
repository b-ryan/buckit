window.LedgerCtrl = ($scope, $routeParams, $location, $modal, $timeout,
                     Account, Transaction, Payee) ->

  $scope.setActiveTab($scope.LEDGER_TAB_INDEX)

  $scope.accounts = []
  $scope.payees = []
  $scope.accountLookup = {} ## TODO use caching instead?
  $scope.transactions = []

  Account.query (accounts) ->
    $scope.accounts = accounts
    for a in accounts
      $scope.accountLookup[a.id] = a
    $scope.changeAccount $routeParams.account_id

  Payee.query (payees) ->
    $scope.payees = payees

  Transaction.query (transactions) ->
    $scope.transactions = transactions

  $scope.$watch 'account', () ->
    if not $scope.account
      return
    $location.path '/ledger/' + $scope.account.id

  $scope.changeAccount = (account_id) ->
    if account_id
      $scope.account = $scope.accountLookup[account_id]
    else
      $scope.account = $scope.accounts[0]

  $scope.hasSplitForAccount = (transaction) ->
    (s for s in transaction.splits \
     when s.account_id == $scope.account.id).length > 0

  $scope.addTransaction = () ->
    $scope.transactions.push
      date: null
      payee_id: null
      splits: [
        {
          account_id: $scope.account.id
          amount: 0
          reconciled_status: 'not_reconciled'
        }
        {
          account_id: null
          amount: 0
          reconciled_status: 'not_reconciled'
        }
      ]
      editing: true
