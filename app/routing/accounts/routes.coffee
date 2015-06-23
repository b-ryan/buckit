angular.module("buckit.routing").config [
  "$stateProvider"
  ($stateProvider) ->

    # TODO perhaps have all templates / controllers for states in a central
    # directory -- make it so that only these templates have ui-view elements

    $stateProvider
      .state "accounts",
        url: "/accounts"
        views:
          "mainView":
            template: "<accounts></accounts>"
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
            template: "<accounts-details></accounts-details>"
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
      .state "accounts.details.transactions",
        url: "/transactions"
        abstract: true
        views:
          "accountsDetailsSubview":
            template: "<ui-view></ui-view>"
      .state "accounts.details.transactions.create",
        url: "/create"
        # this template fills in the ui-view from the abstract parent state
        template:
          "<transaction-editor account-id=\"accountId\"></transaction-editor>"
        controller: [
          "$stateParams"
          "$scope"
          ($stateParams, $scope) ->
            $scope.accountId = $stateParams.accountId
        ]
      .state "accounts.details.transactions.edit",
        url: "/{transactionId:int}/edit"
        # this template fills in the ui-view from the abstract parent state
        template:
          "<transaction-editor account-id=\"accountId\" transaction-id=\"transactionId\"></transaction-editor>"
        controller: [
          "$stateParams"
          "$scope"
          ($stateParams, $scope) ->
            $scope.accountId = $stateParams.accountId
            $scope.transactionId = $stateParams.transactionId
        ]

]
