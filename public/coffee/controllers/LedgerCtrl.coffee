window.LedgerCtrl = (
    $scope,
    $routeParams,
    $location,
    $modal,
    $timeout,
    Account,
    Transaction,
    Payee) ->

  $scope.setActiveTab($scope.LEDGER_TAB_INDEX)

  $scope.accounts = []
  $scope.payees = []
  accountLookup = {}

  Account.query (accounts) ->
    $scope.accounts = accounts
    for a in accounts
      accountLookup[a.id] = a
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
      $scope.account = accountLookup[account_id]
    else
      $scope.account = $scope.accounts[0]

  $scope.hasSplitForAccount = (transaction) ->
    (s for s in transaction.splits \
     when s.account_id == $scope.account.id).length > 0

  $scope.transactionDestination = (transaction) ->
    other_splits = transaction.splits.filter (split) ->
      split.account_id != $scope.account.id
    if other_splits.length == 0
      throw new Error("Can't find any other splits")
    else if other_splits.length > 1
      return 'Splits'
    return accountLookup[other_splits[0].account_id].name

  $scope.transactionAmount = (transaction) ->
    reducer = (sum, split) ->
      sum + if split.account_id == $scope.account.id then split.amount else 0
    return transaction.splits.reduce reducer, 0

  $scope.transactionStatus = (transaction) ->
    matches = transaction.splits.filter (split) ->
      split.account_id == $scope.account.id
    if matches.length == 0
      throw new Error("Can't find account!")
    return matches[0].reconciled_status
