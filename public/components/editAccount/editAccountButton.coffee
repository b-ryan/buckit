window.buckit.directive 'editAccountButton', [
  "componentUrl"
  "Accounts"
  "$modal"
  (componentUrl, Accounts, $modal) ->
    restrict: "E"
    templateUrl: componentUrl("editAccount/editAccountButton.html")
    scope:
      isNewAccount: "="
    link: (scope, elem, attr) ->

      scope.prompt = if scope.isNewAccount \
        then "Create an Account" \
        else "Edit Account"

      scope.editAccount = ->
        instance = $modal.open
          templateUrl: componentUrl("editAccount/editAccountForm.html")
          controller: 'editAccountModalCtrl'

        instance.result.then (account) ->
          Accounts.save account
]
