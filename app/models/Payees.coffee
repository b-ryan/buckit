angular.module("buckit").factory "Payees", [
  "Model"
  (Model) ->
    new Model("Payees", "/api/payees/:id")
]
