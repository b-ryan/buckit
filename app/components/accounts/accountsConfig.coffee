angular.module("buckit").config [
  "$stateProvider"
  ($stateProvider) ->

    # TODO perhaps have all templates / controllers for states in a central
    # directory -- make it so that only these templates have ui-view elements

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
      .state "accounts.details.transactions",
        url: "/transactions"
        abstract: true
        views:
          "accountDetailsSubview":
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
