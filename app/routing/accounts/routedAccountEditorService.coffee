angular.module("buckit.routing").service "routedAccountEditorService", [
  "accountEditorService"
  "$rootScope"
  "$state"
  (accountEditorService, $rootScope, $state) ->

    editWithModal: (accountId) ->
      cancelListener = $rootScope.$on "$stateChangeStart", ->
        accountEditorService.cancelModal()

      accountEditorService.editWithModal(accountId).then (account) ->
        cancelListener()
        $state.go "accounts.details", {accountId: account.id}
      , (reason) ->
        cancelListener()
        unless reason is "cancel function called"
          $state.go "^"

]
