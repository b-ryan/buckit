angular.module("buckit").directive 'buckit', [
  "componentUrl"
  (componentUrl) ->
    restrict: "E"
    templateUrl: componentUrl("buckit.html")
    replace: true
]
