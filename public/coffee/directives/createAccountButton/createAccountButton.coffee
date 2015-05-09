window.buckit.directive 'createAccountButton', [
  "Accounts"
  "$modal"
  (Accounts, $modal) ->
    restrict: "E"
    templateUrl: "/public/coffee/directives/createAccountButton/createAccountButton.html"
    link: (scope, elem, attr) ->
      scope.createAccount = ->
        instance = $modal.open
          templateUrl: "/public/coffee/directives/createAccountButton/createAccountForm.html"
          controller: 'createAccountModalCtrl'

        instance.result.then (account) ->
          Accounts.save account
]
