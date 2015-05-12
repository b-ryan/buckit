window.buckit.directive 'accountList', [
  "componentUrl"
  "Accounts"
  "$state"
  "$stateParams"
  (componentUrl, Accounts, $state, $stateParams) ->
    restrict: "E"
    templateUrl: componentUrl("accounts/accountList.html")
    link: (scope, elem, attr) ->
      scope.accounts = Accounts.query()
      scope.selectedAccountId = $stateParams.id

      scope.accountSelected = ->
        $state.go 'accounts.details', {id: scope.selectedAccountId}
]
