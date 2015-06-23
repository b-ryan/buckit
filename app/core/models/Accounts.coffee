angular.module("buckit.core").factory "Accounts", [
  "Model"
  (Model) ->
    new Model("Accounts", "/api/accounts/:id")
]
