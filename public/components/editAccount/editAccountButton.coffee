window.buckit.directive 'editAccountButton', [
  "componentUrl"
  "Accounts"
  "$modal"
  (componentUrl, Accounts, $modal) ->
    restrict: "E"
    templateUrl: componentUrl("editAccount/editAccountButton.html")
    scope:
      account: "="
      prompt: "="
    link: (scope, elem, attr) ->

      scope.editAccount = ->
        instance = $modal.open
          templateUrl: componentUrl("editAccount/editAccountForm.html")
          controller: 'editAccountModalCtrl'
          resolve:
            account: ->
              scope.account

        instance.result.then (account) ->
          f = if account.id then Accounts.update else Accounts.save
          f account
]
