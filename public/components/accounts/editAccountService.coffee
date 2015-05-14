window.buckit.service 'editAccountService', [
  "$stateParams"
  "$state"
  "$modal"
  "$rootScope"
  "componentUrl"
  ($stateParams, $state, $modal, $rootScope, componentUrl) ->

    editWithModal: (account) ->

      instance = $modal.open
        templateUrl: componentUrl("accounts/editAccountModal.html")
        controller: 'editAccountModalCtrl'
        resolve:
          account: ->
            account

      # Below, there are two ways the user could leave the modal,
      # either by dismissing it directly or by changing the URL.
      # This var describes which means was used so the listeners
      # know how to behave.
      dismissalHandled = false

      $rootScope.$on "$stateChangeStart", (event) ->
        unless dismissalHandled
          console.log "state change about to happen, dismissing modal"
          dismissalHandled = true
          instance.dismiss()

      instance.result.then (account) ->
        console.log account
        dismissalHandled = true
        $state.go "accounts.details", {id: account.id}
      , ->
        unless dismissalHandled
          console.log "Modal was dismissed by user, transitioning back"
          dismissalHandled = true
          $state.go "^"
]
