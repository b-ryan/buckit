window.buckit.directive 'buckit', [
  "componentUrl"
  (componentUrl) ->
    restrict: "E"
    templateUrl: componentUrl("buckit/buckit.html")
    replace: true
    link: (scope, elem, attr) ->
]
