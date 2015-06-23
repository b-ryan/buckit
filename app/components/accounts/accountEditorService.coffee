angular.module("buckit.components").service "accountEditorService", [
  "$modal"
  "componentUrl"
  ($modal, componentUrl) ->

    instance = null

    # returns a promise that will contain the account on success or one of the
    # following possible reasons on error:
    #
    # - "escape key press"
    # - "cancel button press"
    # - "cancel function called"
    editWithModal: (accountId) ->
      instance = $modal.open
        templateUrl: componentUrl("accounts/accountEditorModal.html")
        controller: "accountEditorModalCtrl"
        resolve:
          accountId: ->
            accountId

      promise = instance.result

      promise.catch (reason) ->
        console.log "account editor modal dismissed. Reason:", reason

      promise.finally ->
        instance = null

      return promise

    cancelModal: ->
      instance.dismiss "cancel function called"
]
