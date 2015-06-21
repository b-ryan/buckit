angular.module("buckit.models").factory "Accounts", [
  "Model"
  (Model) ->
    new Model("Accounts", "/api/accounts/:id")
]
