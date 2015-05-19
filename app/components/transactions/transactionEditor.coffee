angular.module("buckit").directive "transactionEditor", [
  "componentUrl"
  (componentUrl) ->
    restrict: "E"
    templateUrl: componentUrl("transactions/transactionEditor.html")
    scope:
      transactionId: "="
]
