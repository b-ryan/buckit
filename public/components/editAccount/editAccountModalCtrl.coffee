window.buckit.controller 'editAccountModalCtrl', [
  "$scope"
  "$modalInstance"
  "account"
  ($scope, $modalInstance, account) ->

    $scope.accountTypes = [
      "liability"
      "asset"
      "income"
      "expense"
      "equity"
    ]

    if account
      $scope.isNewAccount = false
      $scope.account = angular.copy(account)
    else
      $scope.isNewAccount = true
      $scope.account =
        name: null
        type: "asset"

    $scope.create = ->
      $modalInstance.close $scope.account

    $scope.cancel = ->
      $modalInstance.dismiss 'cancel'

]
