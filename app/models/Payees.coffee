angular.module("buckit.models").factory "Payees", [
  "Model"
  (Model) ->
    new Model("Payees", "/api/payees/:id")
]
