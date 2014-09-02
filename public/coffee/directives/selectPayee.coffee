buckit.directive 'selectPayee', ['Payee', (Payee) ->
  restrict: 'E'
  require: 'ngModel'
  scope: {
    'form': '='
  }
  templateUrl: '/public/html/inputLookahead.html'
  link: (scope, elem, attrs, ngModelCtrl) ->
    scope.placeholder = 'Payee'
    Payee.query (payees) ->
      scope.models = payees

      if ngModelCtrl.$modelValue
        Payee.get {id: ngModelCtrl.$modelValue}, (payee) ->
          scope.selectedModel = payee

    isValid = (payee) ->
      typeof payee != 'string' or payee == ''

    scope.$watch 'selectedModel', (payee) ->
      scope.form.$setValidity 'modelInput', isValid(payee)

    scope.modelChanged = (payee) ->
      if typeof payee == 'string'
        console.log 'create new'
      ngModelCtrl.$setViewValue payee.id
      ngModelCtrl.$render()
]
