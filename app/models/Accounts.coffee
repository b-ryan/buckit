angular.module("buckit").factory "Accounts", [
  "Model"
  (Model) ->
    new Model("Accounts", "/api/accounts/:id", Model.identityTransforms)
]
