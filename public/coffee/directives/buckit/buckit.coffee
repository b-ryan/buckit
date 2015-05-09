window.buckit.directive 'buckit', [
  "Accounts"
  (Accounts) ->
    restrict: "E"
    templateUrl: "/public/coffee/directives/buckit/buckit.html"
    replace: true
    link: (scope, elem, attr) ->
      scope.accounts = Accounts.query()
]
