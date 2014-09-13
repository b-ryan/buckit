buckit.directive 'selectPayee', ['Payee', (Payee) ->
  restrict: 'E'
  require: 'ngModel'
  scope: {
  }
  template: '
    <select style="width:100%;" ui-select2="select2Opts" ng-model="selectedIndex">
      <option></option>
      <option ng-repeat="m in models" value="{{$index}}">
        {{m.name}}
      </option>
    </select>
  '
  link: (scope, elem, attrs, ngModelCtrl) ->
    Payee.query (payees) ->
      scope.models = payees

      if ngModelCtrl.$modelValue
        scope.selectedIndex = (i for p, i in payees \
          when p.id == ngModelCtrl.$modelValue)[0]

    scope.$watch 'selectedIndex', (index) ->
      if index?
        payee = scope.models[index]
        ngModelCtrl.$setViewValue payee
        ngModelCtrl.$render()
  controller: ['$scope', ($scope) ->
    $scope.select2Opts =
      placeholder: 'Select Payee'
      allowClear: true
  ]
]
