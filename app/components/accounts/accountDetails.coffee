angular.module("buckit").directive "accountDetails", [
  "componentUrl"
  "$stateParams"
  (componentUrl, $stateParams) ->
    restrict: "E"
    templateUrl: componentUrl("accounts/accountDetails.html")
    link: (scope, elem, attr) ->
      scope.accountId = $stateParams.accountId
]
