window.TransactionCtrl = ($scope, ReconciledStatus, Account) ->

  for s in $scope.transaction.splits
    s.account = $scope.accountLookup[s.account_id]

  $scope.reconciled_statuses = ReconciledStatus.all()

  $scope.account_split = (s for s in $scope.transaction.splits \
    when s.account_id == $scope.account.id)[0]

  $scope.non_account_splits = (s for s in $scope.transaction.splits \
    when s.account_id != $scope.account.id)

  $scope.edit = () ->
    $scope.editing = true
    $scope.newTransaction = $.extend true, {}, $scope.transaction

  $scope.addSplit = () ->
    $scope.newTransaction.splits.push
      id: null
      transaction_id: $scope.newTransaction.id
      account_id: null
      amount: 0
      reconciled_status: 'not_reconciled'

  $scope.ok = () ->
    $scope.editing = false
    console.log $scope.newTransaction

  $scope.cancel = () ->
    $scope.editing = false
