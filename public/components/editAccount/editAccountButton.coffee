window.buckit.directive 'editAccountButton', [
  "componentUrl"
  "Accounts"
  "$modal"
  (componentUrl, Accounts, $modal) ->
    restrict: "A"
    scope:
      account: "="
    link: (scope, elem, attr) ->

      $(elem).on 'click', ->
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
