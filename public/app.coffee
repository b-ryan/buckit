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
          "editAccountService"
          (editAccountService) ->
            editAccountService.editWithModal null
        ]
      .state "accounts.details",
        url: "/{id:int}"
        template: "<account-details></account-details>"
      .state "budget",
        url: "/budget"
        template: "<budget-view></budget-view>"
]

window.buckit = buckit
