buckit.directive 'selectAccount', () ->
  restrict: 'E'
  scope: {
    ngModel: '='
  }
  template: '
    <input class="form-control" type="text"
      ng-model="ngModel"
      placeholder="Account"
      typeahead="a as a.name for a in accounts | filter:$viewValue"
      typeahead-append-to-body="true">
    '
  controller: ['$scope', 'Account', ($scope, Account) ->
    Account.query (ps) ->
      $scope.accounts = ps
  ]
