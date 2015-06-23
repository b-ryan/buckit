angular.module("buckit.core").factory "Payees", [
  "Model"
  (Model) ->
    new Model("Payees", "/api/payees/:id")
]
