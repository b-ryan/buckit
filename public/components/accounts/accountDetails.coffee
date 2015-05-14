window.buckit.directive 'accountDetails', [
  "componentUrl"
  "Accounts"
  "$stateParams"
  (componentUrl, Accounts, $stateParams) ->
    restrict: "E"
    templateUrl: componentUrl("accounts/accountDetails.html")
    link: (scope, elem, attr) ->
      Accounts.get({id: $stateParams.id}).$promise.then (account) ->
        scope.account = account
      , (error) ->
        alert error
]
