window.buckit.directive 'buckit', [
  "componentUrl"
  "Accounts"
  (componentUrl, Accounts) ->
    restrict: "E"
    templateUrl: componentUrl("buckit/buckit.html")
    replace: true
    link: (scope, elem, attr) ->
      scope.accounts = Accounts.query()
]
