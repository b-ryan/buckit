# This code is currently duplicated from the selectPayee directive.
# The reason is that I already know this directive will need to drastically
# change. Accounts can be nested and should also indicate what type of account
# they are.
buckit.directive 'selectAccount',
  ['$compile', 'Account', ($compile, Account) ->
    replace: true
    restrict: 'E'
    require: 'ngModel'
    scope: {}
    template: '
      <div class="selectAccount btn-group" ng-class="{open:dropdown.open}">
        <button class="btn dropdown-label">XYZ</button>
        <button class="btn dropdown-toggle" ng-click="toggleDropdown()">
          <span class="caret"></span>
        </button>
      </div>
    '
    link: (scope, elem, attrs, ngModelCtrl) ->
      Account.query (accounts) ->
        scope.models = accounts

        if ngModelCtrl.$modelValue
          scope.selectedIndex = (i for a, i in accounts \
            when a.id == ngModelCtrl.$modelValue)[0]

      backdrop = angular.element '
        <div class="dropdownBackdrop" ng-if="dropdown.open"
             ng-click="toggleDropdown()">
        </div>
      '
      $('body').append backdrop
      $compile(backdrop)(scope)

      dropdown = angular.element '
        <div class="selectAccountDropdown" ng-class="{open:dropdown.open}">
          <ul class="dropdown-menu">
            <li>
              <a>Hi <button ng-click="expand($event)">click</button></a>
            </li>
          </ul>
        </div>
      '
      $('body').append dropdown
      $compile(dropdown)(scope)

      positionDropdown = ->
        dropdown.css 'top', (elem.offset().top + elem.outerHeight()) + 'px'
        dropdown.css 'left', elem.offset().left + 'px'

      positionDropdown()
      $(window).on 'resize', ->
        positionDropdown()

      elem.on '$destroy', ->
        backdrop.remove()
        dropdown.remove()

      scope.dropdown =
        open: false

      scope.toggleDropdown = ->
        scope.dropdown.open = !scope.dropdown.open

      scope.$watch 'selectedIndex', (index) ->
        if index?
          account = scope.models[index]
          ngModelCtrl.$setViewValue account.id
          ngModelCtrl.$render()
]
