angular.module("buckit.components").directive "accountsDetails", [
  "appUrl"
  "$stateParams"
  (appUrl, $stateParams) ->
    restrict: "E"
    templateUrl: appUrl("routing/accounts/accountsDetails.html")
    link: (scope, elem, attr) ->
      scope.accountId = $stateParams.accountId
]
