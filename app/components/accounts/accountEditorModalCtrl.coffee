angular.module("buckit.components").controller "accountEditorModalCtrl", [
  "$scope"
  "$modalInstance"
  "Accounts"
  "accountId"
  ($scope, $modalInstance, Accounts, accountId) ->

    $scope.accountTypes = [
      "liability"
      "asset"
      "income"
      "expense"
      "equity"
    ]

    if accountId
      $scope.isNewAccount = false
      Accounts.get({id: accountId}).then (account) ->
        $scope.account = angular.copy(account)
      , (error) ->
        alert error
    else
      $scope.isNewAccount = true
      $scope.account =
        name: null
        type: "asset"

    $scope.save = ->
      f = if $scope.account.id then Accounts.update else Accounts.save
      f($scope.account).then (account) ->
        $modalInstance.close account
      , (error) ->
        alert "Error saving!"

    $scope.cancel = ->
      $modalInstance.dismiss "cancel button press"

]
