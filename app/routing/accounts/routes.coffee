angular.module("buckit.routing").config [
  "$stateProvider"
  ($stateProvider) ->

    $stateProvider
      .state "accounts",
        url: "/accounts"
        views:
          "mainView":
            template: "<accounts></accounts>"
      .state "accounts.create",
        url: "/create"
        onEnter: [
          "routedAccountEditorService"
          (routedAccountEditorService) ->
            routedAccountEditorService.editWithModal null
        ]
      .state "accounts.details",
        url: "/{accountId:int}"
        views:
          "accountsSubview":
            template: "<accounts-details></accounts-details>"
      .state "accounts.details.create",
        url: "/create"
        onEnter: [
          "routedAccountEditorService"
          (routedAccountEditorService) ->
            routedAccountEditorService.editWithModal null
        ]
      .state "accounts.details.edit",
        url: "/edit"
        onEnter: [
          "routedAccountEditorService"
          "$stateParams"
          (routedAccountEditorService, $stateParams) ->
            routedAccountEditorService.editWithModal $stateParams.accountId
        ]
      .state "accounts.details.transactions",
        url: "/transactions"
        abstract: true
      .state "accounts.details.transactions.create",
        url: "/create"
        views:
          "accountsDetailsSubview@accounts.details":
            template: "
              <transaction-editor account-id=\"accountId\">
              </transaction-editor>
            "
            controller: [
              "$stateParams"
              "$scope"
              ($stateParams, $scope) ->
                $scope.accountId = $stateParams.accountId
            ]
      .state "accounts.details.transactions.details",
        url: "/{transactionId:int}"
        abstract: true
      .state "accounts.details.transactions.details.edit",
        url: "/edit"
        views:
          "accountsDetailsSubview@accounts.details":
            template: "
              <transaction-editor account-id=\"accountId\"
                transaction-id=\"transactionId\">
              </transaction-editor>
            "
            controller: [
              "$stateParams"
              "$scope"
              ($stateParams, $scope) ->
                $scope.transactionId = $stateParams.transactionId
            ]

]
