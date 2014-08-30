buckit.directive 'selectPayee', () ->
  restrict: 'E'
  scope: {
    ngModel: '='
  }
  template: '
    <input class="form-control" type="text"
      ng-model="ngModel"
      placeholder="Payee"
      typeahead="p.id as p.name for p in payees | filter:$viewValue"
      typeahead-append-to-body="true">
    '
  controller: ['$scope', 'Payee', ($scope, Payee) ->
    Payee.query (ps) ->
      $scope.payees = ps
  ]
