buckit.directive 'selectAccount', ['Account', (Account) ->
  restrict: 'E'
  require: 'ngModel'
  scope: {}
  template: '
    <select style="width:100%;" ui-select2 ng-model="selectedModel">
      <option ng-repeat="m in models" value="{{$index}}">
        {{m.name}}
      </option>
    </select>
  '
  link: (scope, elem, attrs, ngModelCtrl) ->
    scope.placeholder = 'Account'
    Account.query (accounts) ->
      scope.models = accounts

      if ngModelCtrl.$modelValue
        Account.get {id: ngModelCtrl.$modelValue}, (account) ->
          scope.selectedModel = account

    scope.$watch 'selectedModel', ($index) ->
      if $index?
        console.log 'changed', scope.models[$index]
]
