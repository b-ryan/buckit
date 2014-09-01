buckit.directive 'editTransaction', () ->
  restrict: 'E'
  require: 'ngModel'
  scope: {
    'account': '='
    'transaction': '='
  }
  templateUrl: '/public/html/edit_transaction.html'
  controller: ['$scope', 'enums', 'Account', ($scope, enums, Account) ->
    $scope.name = 'buck'
    $scope.enums = enums
    $scope.datePicker = {isOpen: false}

    $scope.account_split = (s for s in $scope.transaction.splits \
      when s.account_id == $scope.account.id)[0]

    $scope.non_account_splits = (s for s in $scope.transaction.splits \
      when s.account_id != $scope.account.id)

    $scope.openDatePicker = ($event) ->
      $event.preventDefault()
      $event.stopPropagation()
      $scope.datePicker.isOpen = true

    $scope.addSplit = () ->
      $scope.transaction.splits.push
        id: null
        transaction_id: $scope.transaction.id
        account_id: null
        amount: 0
        reconciled_status: 'not_reconciled'

    $scope.cancel = () ->
      $scope.editing = false
      $scope.transaction = $scope.backup
      $scope.backup = null

    $scope.save = () ->
      console.log $scope.transaction
      # func = if $scope.transaction.id then Transaction.update else Transaction.save
      # func $scope.transaction, (transaction) ->
      #   $scope.transaction = transaction
      #   $scope.editing = false

  ]
