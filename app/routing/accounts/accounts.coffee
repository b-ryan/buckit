angular.module("buckit.routing").directive "accounts", [
  "appUrl"
  "Accounts"
  "$state"
  "$stateParams"
  "$rootScope"
  (appUrl, Accounts, $state, $stateParams, $rootScope) ->
    restrict: "E"
    templateUrl: appUrl("routing/accounts/accounts.html")
    link: (scope, elem, attr) ->
      scope.accounts = []

      Accounts.query().then (accounts) ->
        scope.accounts = accounts
      , (error) ->
        alert error

      scope.selectedAccountId = $stateParams.accountId

      $rootScope.$on "$stateChangeSuccess", ->
        scope.selectedAccountId = $stateParams.accountId

      $rootScope.$on "Accounts.POST", (event, account) ->
        scope.accounts.push account

      scope.accountSelected = ->
        $state.go "accounts.details", {accountId: scope.selectedAccountId}

      scope.createAccount = ->
        # I would love for this to be doable with ui-sref but it currently
        # doesn't work. Issue about it:
        # https://github.com/angular-ui/ui-router/issues/1031
        $state.go ".create"
]
