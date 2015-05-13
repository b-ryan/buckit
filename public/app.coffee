buckit = angular.module "buckit", [
  "ngResource"
  "ui.bootstrap"
  "ui.select2"
  "ui.router"
]

buckit.config [
  "$stateProvider"
  ($stateProvider) ->

    # For any unmatched url, redirect to some "unknown" state
    # This state can then have a controller which can smart-route to the
    # last known position or something like that
    # $urlRouterProvider.otherwise("/state1");

    $stateProvider
      .state "accounts",
        url: "/accounts"
        template: "<account-list></account-list>"
      .state "accounts.create",
        url: "/create"
        onEnter: [
          "$stateParams"
          "$state"
          "$modal"
          "$rootScope"
          "componentUrl"
          ($stateParams, $state, $modal, $rootScope, componentUrl) ->

            instance = $modal.open
              templateUrl: componentUrl("accounts/editAccountForm.html")
              controller: 'editAccountModalCtrl'
              resolve:
                account: ->
                  null

            # Below, there are two ways the user could leave the modal,
            # either by dismissing it directly or by changing the URL.
            # This var describes which means was used so the listeners
            # know how to behave.
            dismissalHandled = false

            listener = $rootScope.$on "$stateChangeStart", (event) ->
              unless dismissalHandled
                console.log "state change about to happen, dismissing modal"
                dismissalHandled = true
                instance.dismiss()

            instance.result.then (account) ->
              console.log account
              dismissalHandled = true
              $state.transitionTo "accounts"
              # f = if account.id then Accounts.update else Accounts.save
              # f account
            , ->
              unless dismissalHandled
                console.log "Modal was dismissed by user, transitioning back"
                dismissalHandled = true
                # maybe go to whatever the previous state was rather than
                # to accounts
                $state.transitionTo "accounts"
        ]
      .state "accounts.details",
        url: "/{id:int}"
        template: "<account-details></account-details>"
      .state "budget",
        url: "/budget"
        template: "<budget-view></budget-view>"
]

window.buckit = buckit
