# TODO use routing to separate the parent ledger from this stuff
# maybe look into the angular router project
window.TransactionCtrl = ($scope, ReconciledStatus, Account, Transaction) ->

  $scope.reconciled_statuses = ReconciledStatus.all()
  $scope.editing = false
  $scope.datePicker = {isOpen: false}

  $scope.account_split = (s for s in $scope.transaction.splits \
    when s.account_id == $scope.account.id)[0]

  $scope.non_account_splits = (s for s in $scope.transaction.splits \
    when s.account_id != $scope.account.id)

  if $scope.non_account_splits.length == 1
    Account.get {id: $scope.non_account_splits[0].account_id}, (account) ->
      $scope.accountDisplayName = account.name
  else if $scope.non_account_splits.length > 1
    'Splits'

  $scope.edit = () ->
    $scope.editing = true
    $scope.backup = $.extend true, {}, $scope.transaction

  $scope.addSplit = () ->
    $scope.transaction.splits.push
      id: null
      transaction_id: $scope.transaction.id
      account_id: null
      amount: 0
      reconciled_status: 'not_reconciled'

  $scope.openDatePicker = ($event) ->
    $event.preventDefault()
    $event.stopPropagation()
    $scope.datePicker.isOpen = true

  $scope.save = () ->
    console.log $scope.transaction
    # func = if $scope.transaction.id then Transaction.update else Transaction.save
    # func $scope.transaction, (transaction) ->
    #   $scope.transaction = transaction
    #   $scope.editing = false

  $scope.cancel = () ->
    $scope.editing = false
    $scope.transaction = $scope.backup
    $scope.backup = null
