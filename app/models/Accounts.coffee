angular.module("buckit").factory "Accounts", [
  "Model"
  (Model) ->
    Model.create "/api/accounts/:id", Model.identityTransforms
]
