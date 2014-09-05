buckit.directive 'selectPayee', ['Payee', (Payee) ->
  restrict: 'E'
  require: 'ngModel'
  scope: {
  }
  template: '
    <select style="width:100%;" ui-select2 ng-model="selectedIndex">
      <option ng-repeat="m in models" value="{{$index}}">
        {{m.name}}
      </option>
    </select>
  '
  link: (scope, elem, attrs, ngModelCtrl) ->
    scope.placeholder = 'Payee'
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
]
