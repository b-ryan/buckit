buckit.directive 'selectPayee', ['Payee', (Payee) ->
  restrict: 'E'
  require: 'ngModel'
  scope: {
  }
  template: '
    <div class="btn-group">
      <button class="btn button-label btn-info">XYZ</button>
      <button class="btn btn-info dropdown-toggle" data-toggle="dropdown">
        <span class="caret"></span>
      </button>
      <ul class="dropdown-menu" role="menu" aria-labelledby="dLabel">
        <li role="presentation">
          <a>Hi <button ng-click="expand($event)" role="menuitem">click</button></a>
        </li>
      </ul>
    </div>
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

    scope.expand = ($event) ->
      $event.stopPropagation()
      console.log 'expand'
]
