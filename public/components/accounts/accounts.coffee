angular.module("buckit").config [
  "$stateProvider"
  ($stateProvider) ->

    $stateProvider
      .state "accounts",
        url: "/accounts"
        abstract: true
        template: "<accounts-view></accounts-view>"
      .state "accounts.list",
        url: ""
        template: "<account-list></account-list>"
      .state "accounts.list.create",
        url: "/create"
        onEnter: [
          "editAccountService"
          (editAccountService) ->
            editAccountService.editWithModal null
        ]
      .state "accounts.details",
        url: "/{id:int}"
        template: "<account-details></account-details>"
      .state "accounts.details.create",
        url: "/create"
        onEnter: [
          "editAccountService"
          (editAccountService) ->
            editAccountService.editWithModal null
        ]
      .state "accounts.details.edit",
        url: "/edit"
        onEnter: [
          "editAccountService"
          "$stateParams"
          (editAccountService, $stateParams) ->
            editAccountService.editWithModal $stateParams.id
        ]

]
