angular.module("buckit.components").directive "accountsDetailsTransactionsCreate", [
  "appUrl"
  (appUrl) ->
    restrict: "E"
    templateUrl: appUrl("routing/accounts/accountsDetailsTransactionsCreate.html")
    link: (scope, elem, attr) ->
]
