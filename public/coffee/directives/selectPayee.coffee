buckit.directive 'selectPayee', () ->
  restrict: 'E'
  scope: {
    ngModel: '='
  }
  template: '
    <input class="form-control" type="text"
      ng-model="ngModel"
      placeholder="Payee"
      typeahead="p as p.name for p in payees | filter:$viewValue">
    '
  controller: ['$scope', 'Payee', ($scope, Payee) ->
    Payee.query (ps) ->
      $scope.payees = ps
  ]
