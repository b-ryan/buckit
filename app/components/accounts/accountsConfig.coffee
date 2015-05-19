angular.module("buckit").config [
  "$stateProvider"
  ($stateProvider) ->

    $stateProvider
      .state "accounts",
        url: "/accounts"
        views:
          "mainView":
            template: "<accounts-view></accounts-view>"
      .state "accounts.create",
        url: "/create"
        onEnter: [
          "accountEditorService"
          (accountEditorService) ->
            accountEditorService.editWithModal null
        ]
      .state "accounts.details",
        url: "/{accountId:int}"
        views:
          "accountsSubview":
            template: "<account-details></account-details>"
      .state "accounts.details.create",
        url: "/create"
        onEnter: [
          "accountEditorService"
          (accountEditorService) ->
            accountEditorService.editWithModal null
        ]
      .state "accounts.details.edit",
        url: "/edit"
        onEnter: [
          "accountEditorService"
          "$stateParams"
          (accountEditorService, $stateParams) ->
            accountEditorService.editWithModal $stateParams.accountId
        ]
      .state "accounts.details.transaction",
        url: "/transactions/{transactionId:int}"
        abstract: true
        views:
          "accountDetailsSubview":
            template: "<ui-view></ui-view>"
      .state "accounts.details.transaction.edit",
        url: "/edit"
        # this template fills in the ui-view from the abstract parent state
        template:
          "<transaction-editor transaction-id=\"transactionId\">" + \
          "</transaction-editor>"
        controller: [
          "$stateParams"
          "$scope"
          ($stateParams, $scope) ->
            $scope.transactionId = $stateParams.transactionId
        ]

]
