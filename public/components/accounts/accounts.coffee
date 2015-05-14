window.buckit.directive 'accounts', [
  "componentUrl"
  "Accounts"
  "$state"
  "$stateParams"
  "$rootScope"
  (componentUrl, Accounts, $state, $stateParams, $rootScope) ->
    restrict: "E"
    templateUrl: componentUrl("accounts/accounts.html")
    link: (scope, elem, attr) ->
      scope.accounts = Accounts.query()
      scope.selectedAccountId = $stateParams.id

      $rootScope.$on '$stateChangeSuccess', ->
        scope.selectedAccountId = $stateParams.id

      scope.accountSelected = ->
        $state.go 'accounts.details', {id: scope.selectedAccountId}

      scope.createAccount = ->
        # I would love for this to be doable with ui-sref but it currently
        # doesn't work. Issue about it:
        # https://github.com/angular-ui/ui-router/issues/1031
        $state.go ".create"
]
