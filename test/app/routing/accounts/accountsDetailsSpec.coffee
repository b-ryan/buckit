describe "accountsDetails", ->
  $state = null
  scope = null
  elem = null

  beforeEach module("buckit.routing")
  beforeEach module("buckit.templates")

  beforeEach module(($provide) ->
    $provide.factory "ledgerDirective", ->
      {}
    null
  )

  beforeEach inject(($injector) ->
    $state = $injector.get "$state"
    $state.go = jasmine.createSpy "go"

    elem = angular.element "
      <accounts-details account-id=\"1\">
      </accounts-details>
    "
    $compile = $injector.get "$compile"
    scope = $injector.get "$rootScope"
    $compile(elem)(scope)
    scope.$digest()
  )

  it "routes correctly when addTransaction called", ->
    button = elem.find "div.accounts-details button"
    expect(button.length).toBe(1)

    button.click()
    scope.$digest()

    expect($state.go).toHaveBeenCalledWith(".transactions.create")

    # adding the additional test below ensures that sending the $state to
    # .transactions.create will actually take us to the correct URL.
    # otherwise the routing definitions may have changed and if the test is
    # not updated, then we wouldn't really be testing anything in the line
    # above.
    expect($state.href("accounts.details.transactions.create", {accountId: 1}))
      .toBe("#/accounts/1/transactions/create")
