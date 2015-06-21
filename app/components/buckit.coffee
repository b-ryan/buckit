# this can just be a template in buckit.routing
angular.module("buckit.components").directive 'buckit', [
  "componentUrl"
  (componentUrl) ->
    restrict: "E"
    templateUrl: componentUrl("buckit.html")
]
