window.TransactionCtrl = ($scope, ReconciledStatus, Account, Transaction) ->

  for s in $scope.transaction.splits
    s.account = $scope.accountLookup[s.account_id]

  $scope.reconciled_statuses = ReconciledStatus.all()

  $scope.account_split = (s for s in $scope.transaction.splits \
    when s.account_id == $scope.account.id)[0]

  $scope.non_account_splits = (s for s in $scope.transaction.splits \
    when s.account_id != $scope.account.id)

  $scope.edit = () ->
    $scope.transaction.editing = true
    $scope.backup = $.extend true, {}, $scope.transaction

  $scope.addSplit = () ->
    $scope.transaction.splits.push
      id: null
      transaction_id: $scope.transaction.id
      account_id: null
      amount: 0
      reconciled_status: 'not_reconciled'

  $scope.ok = () ->
    func = if $scope.transaction.id then Transaction.update else Transaction.save
    func $scope.transaction, (transaction) ->
      $scope.transaction = transaction
      $scope.transaction.editing = false

  $scope.cancel = () ->
    $scope.transaction.editing = false
    $scope.transaction = $scope.backup
    $scope.backup = null
