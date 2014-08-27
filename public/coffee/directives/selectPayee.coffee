buckit.directive 'selectPayee', () ->
  restrict: 'A'
  scope: {}
  template: '
    <input class="form-control" type="text"
      ng-model="transaction.payee"
      placeholder="Payee"
      typeahead="p as p.name for p in payees | filter:$viewValue">
    '
  controller: ['$scope', 'Payee', ($scope, Payee) ->
    Payee.query (ps) ->
      $scope.payees = ps
      console.log ps
  ]
