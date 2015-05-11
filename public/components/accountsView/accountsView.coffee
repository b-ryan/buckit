window.buckit.directive 'accountsView', [
  "componentUrl"
  "Accounts"
  (componentUrl, Accounts) ->
    restrict: "E"
    templateUrl: componentUrl("accountsView/accountsView.html")
    link: (scope, elem, attr) ->
      scope.accounts = Accounts.query()
]
