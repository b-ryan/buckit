buckit.directive 'selectAccount', ['Account', (Account) ->
  restrict: 'E'
  require: 'ngModel'
  scope: {}
  template: '
    <input class="form-control" type="text" placeholder="Account"
      ng-model="selectedAccount"
      ng-blur="accountChanged(selectedAccount)"
      typeahead="a as a.name for a in accounts | filter:$viewValue"
      typeahead-append-to-body="true">
    '
  link: (scope, elem, attrs, ngModelCtrl) ->
    Account.query (accounts) ->
      scope.accounts = accounts

      Account.get {id: ngModelCtrl.$modelValue}, (account) ->
        console.log account
        scope.selectedAccount = account

    scope.accountChanged = (account) ->
      ngModelCtrl.$setViewValue account.id
      ngModelCtrl.$render()
]
