angular.module("buckit").directive 'accounts', [
  "componentUrl"
  "Accounts"
  "$state"
  "$stateParams"
  "$rootScope"
  (componentUrl, Accounts, $state, $stateParams, $rootScope) ->
    restrict: "E"
    templateUrl: componentUrl("accounts/accounts.html")
    link: (scope, elem, attr) ->
      Accounts.query().$promise.then (accounts) ->
        scope.accounts = accounts
      , (error) ->
        alert error

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
