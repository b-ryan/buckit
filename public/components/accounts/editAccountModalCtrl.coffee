window.buckit.controller 'editAccountModalCtrl', [
  "$scope"
  "$modalInstance"
  "Accounts"
  "account"
  ($scope, $modalInstance, Accounts, account) ->

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

    $scope.save = ->
      f = if $scope.account.id then Accounts.update else Accounts.save
      f($scope.account).$promise.then (account) ->
        $modalInstance.close account
      , (response) ->
        alert "Error saving!"

    $scope.cancel = ->
      $modalInstance.dismiss 'cancel'

]
