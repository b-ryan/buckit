angular.module("buckit").directive 'accountList', [
  "componentUrl"
  (componentUrl) ->
    restrict: "E"
    templateUrl: componentUrl("accounts/accountList.html")
]
