window.buckit.directive 'accountDetails', [
  "componentUrl"
  "Accounts"
  "$stateParams"
  (componentUrl, Accounts, $stateParams) ->
    restrict: "E"
    templateUrl: componentUrl("accounts/accountDetails.html")
    link: (scope, elem, attr) ->
      scope.account = Accounts.get {id: $stateParams.id}
]
