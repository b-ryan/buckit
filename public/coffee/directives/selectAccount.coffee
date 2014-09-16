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
        <button class="btn dropdown-label">{{selectedAccount.name}}</button>
        <button class="btn dropdown-toggle" ng-click="toggleDropdown()">
          <span class="caret"></span>
        </button>
      </div>
    '
    link: (scope, elem, attrs, ngModelCtrl) ->
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
            <li ng-repeat="account in accounts">
              <a ng-click="selectAccount(account)">{{account.name}}</a>
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

      Account.query (accounts) ->
        scope.accounts = accounts

        if ngModelCtrl.$modelValue
          scope.selectedAccount = (a for a in accounts \
            when a.id == ngModelCtrl.$modelValue)[0]

      scope.selectAccount = (account) ->
        scope.dropdown.open = false
        scope.selectedAccount = account
        ngModelCtrl.$setViewValue account.id
        ngModelCtrl.$render()
]
