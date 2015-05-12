window.buckit.directive 'buckitNavbar', [
  "componentUrl"
  "$location"
  (componentUrl, $location) ->
    restrict: "E"
    templateUrl: componentUrl("navigation/buckitNavbar.html")
]
