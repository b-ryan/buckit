buckit.directive 'selectAccount', ['Account', (Account) ->
  restrict: 'E'
  require: 'ngModel'
  scope: {}
  templateUrl: '/public/html/inputLookahead.html'
  link: (scope, elem, attrs, ngModelCtrl) ->
    scope.placeholder = 'Account'
    Account.query (accounts) ->
      scope.models = accounts

      if ngModelCtrl.$modelValue
        Account.get {id: ngModelCtrl.$modelValue}, (account) ->
          scope.selectedModel = account

    scope.modelChanged = (account) ->
      ngModelCtrl.$setViewValue account.id
      ngModelCtrl.$render()
]
