window.EditTransactionCtrl = ($scope, $timeout, Transaction, Split) ->

  $scope.statuses = [
    'not_reconciled'
    'cleared'
    'reconciled'
  ]

  $scope.reset = () ->
    $scope.date = new Date()
    $scope.payeeName = null
    $scope.payeeId = null
    $scope.destAccountName = null
    $scope.destAccountId = null
    $scope.amount = 0
    $scope.status = 'not_reconciled'

  findByName = (list, name) ->
    matches = list.filter (x) ->
      x.name == name
    matches[0]

  $scope.updatePayeeId = () ->
    payee = findByName $scope.payees, $scope.payeeName
    $scope.payeeId = payee.id

  $scope.updateAccountId = () ->
    account = findByName $scope.accounts, $scope.destAccountName
    $scope.destAccountId = account.id

  $scope.saveTransaction = () ->
    transaction = new Transaction
      date: $scope.date
      payee_id: $scope.payeeId
      splits: [
        new Split(
          account_id: $scope.account.id
          amount: $scope.amount * -1
          reconciled_status: $scope.status
        )

        new Split(
          account_id: $scope.destAccountId
          amount: $scope.amount * 1
          reconciled_status: 'not_reconciled'
        )
      ]

    transaction.$save()

  $scope.openDatepicker = () ->
    $timeout () ->
      $scope.datepickerOpened = true

  $scope.reset()
