window.NewAccountCtrl = ($scope, $modalInstance, Account) ->

  $scope.new_account = new Account()

  $scope.account_types = [
    'liability'
    'asset'
    'income'
    'expense'
    'equity'
  ]

  $scope.ok = () ->
    $modalInstance.close $scope.new_account

  $scope.cancel = () ->
    $modalInstance.dismiss 'cancel'
