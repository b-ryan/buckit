window.buckit.directive 'buckitNavbar', [
  "componentUrl"
  (componentUrl) ->
    restrict: "E"
    templateUrl: componentUrl("navigation/buckitNavbar.html")
    link: (scope, elem, attr) ->
]
