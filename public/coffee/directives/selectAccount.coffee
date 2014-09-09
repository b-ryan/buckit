# This code is currently duplicated from the selectPayee directive.
# The reason is that I already know this directive will need to drastically
# change. Accounts can be nested and should also indicate what type of account
# they are.
buckit.directive 'selectAccount', ['Account', (Account) ->
  restrict: 'E'
  require: 'ngModel'
  scope: {}
  template: '
    <select style="width:100%;" ui-select2 ng-model="selectedIndex">
      <option ng-repeat="m in models" value="{{$index}}">
        {{m.name}}
      </option>
    </select>
  '
  link: (scope, elem, attrs, ngModelCtrl) ->
    Account.query (accounts) ->
      scope.models = accounts

      if ngModelCtrl.$modelValue
        scope.selectedIndex = (i for a, i in accounts \
          when a.id == ngModelCtrl.$modelValue)[0]

    scope.$watch 'selectedIndex', (index) ->
      if index?
        account = scope.models[index]
        ngModelCtrl.$setViewValue account.id
        ngModelCtrl.$render()
]
