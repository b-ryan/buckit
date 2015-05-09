window.buckit.controller 'createAccountModalCtrl', [
  "$scope"
  "$modalInstance"
  ($scope, $modalInstance) ->

    $scope.accountTypes = [
      "liability"
      "asset"
      "income"
      "expense"
      "equity"
    ]

    $scope.account =
      name: null
      type: "asset"

    $scope.create = ->
      $modalInstance.close $scope.account

    $scope.cancel = ->
      $modalInstance.dismiss 'cancel'
]
