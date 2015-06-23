describe "accounts directive", ->
  $httpBackend = null
  $location = null
  scope = null
  elem = null

  beforeEach module("buckit.routing")
  beforeEach module("buckit.templates")

  beforeEach inject(($injector) ->
    $httpBackend = $injector.get "$httpBackend"
    $httpBackend.when("GET", "/api/accounts")
      .respond({objects: [
        {
          id: 1
          parent_id: null
          name: "account 1"
          type: "asset"
        }
        {
          id: 2
          parent_id: null
          name: "account 2"
          type: "liability"
        }
      ]})

    $location = $injector.get "$location"

    elem = angular.element "<accounts></accounts>"
    $compile = $injector.get "$compile"
    scope = $injector.get "$rootScope"
    $compile(elem)(scope)
    scope.$digest()

    $httpBackend.flush()
  )

  afterEach ->
    $httpBackend.verifyNoOutstandingExpectation()
    $httpBackend.verifyNoOutstandingRequest()

  it "handles the <select> properly", ->
    select = elem.find "div.accounts div select"
    expect(select.length).toBe(1)

    options = select.find "option"
    expect(options.length).toBe(3) # 2 accounts + 1 blank
    expect(options.eq(1).text()).toBe("account 1")
    expect(options.eq(2).text()).toBe("account 2")

    scope.selectedAccountId = 1
    scope.accountSelected()
    scope.$digest()

    expect($location.url()).toBe("/accounts/1")
