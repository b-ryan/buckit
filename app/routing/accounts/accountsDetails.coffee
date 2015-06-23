angular.module("buckit.components").directive "accountsDetails", [
  "appUrl"
  "$stateParams"
  "$state"
  (appUrl, $stateParams, $state) ->
    restrict: "E"
    templateUrl: appUrl("routing/accounts/accountsDetails.html")
    link: (scope, elem, attr) ->
      scope.accountId = $stateParams.accountId

      scope.addTransaction = ->
        $state.go ".transactions.create"
]
