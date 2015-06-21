angular.module("buckit.components").directive "accountDetails", [
  "componentUrl"
  "$stateParams"
  (componentUrl, $stateParams) ->
    restrict: "E"
    templateUrl: componentUrl("accounts/accountDetails.html")
    link: (scope, elem, attr) ->
      scope.accountId = $stateParams.accountId
]
