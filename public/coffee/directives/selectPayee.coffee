buckit.directive 'selectPayee', ['Payee', (Payee) ->
  restrict: 'E'
  require: 'ngModel'
  scope: {
  }
  templateUrl: '/public/html/inputLookahead.html'
  link: (scope, elem, attrs, ngModelCtrl) ->
    scope.placeholder = 'Payee'
    Payee.query (payees) ->
      scope.models = payees

      if ngModelCtrl.$modelValue
        Payee.get {id: ngModelCtrl.$modelValue}, (payee) ->
          scope.selectedModel = payee

    scope.$watch 'selectedModel', (payee) ->
      ngModelCtrl.$setViewValue payee
      ngModelCtrl.$render()
]
