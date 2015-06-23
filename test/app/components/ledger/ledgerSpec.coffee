describe "ledger directive", ->
  $httpBackend = null
  $compile = null
  scope = null
  elem = null

  beforeEach module("buckit.components")
  beforeEach module("buckit.templates")

  beforeEach inject(($injector) ->
    $httpBackend = $injector.get "$httpBackend"
    $compile = $injector.get "$compile"
    scope = $injector.get "$rootScope"

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

    $httpBackend.when("GET", "/api/accounts/1")
      .respond(
        id: 1
        parent_id: null
        name: "account 1"
        type: "asset"
      )

    q = encodeURI(angular.toJson(
      filters: [
        name: "splits__account_id"
        op: "any"
        val: 1
      ]
    ))

    $httpBackend.when("GET", "/api/transactions?q=#{q}")
      .respond({objects: [
        {
          id: 1
          date: "2015-06-01"
          payee_id: null
          splits: [
            {
              id: 1
              transaction_id: 1
              account_id: 1
              amount: -25.0
              reconciled_status: "not_reconciled"
            }
            {
              id: 2
              transaction_id: 1
              account_id: 2
              amount: 25.0
              reconciled_status: "not_reconciled"
            }
          ]
        }
      ]})

    elem = angular.element "<ledger account-id=\"1\"></ledger>"
    $compile(elem)(scope)
    scope.$digest()

    $httpBackend.flush()
  )

  afterEach ->
    $httpBackend.verifyNoOutstandingExpectation()
    $httpBackend.verifyNoOutstandingRequest()

  it "should do something", ->
    rows = elem.find "div.ledger table tbody tr"
    expect(rows.length).toBe(1)

    tds = rows.find "td"
    expect(tds.length).toBe(6)
    expect(tds.eq(0).text()).toBe("1")
    expect(tds.eq(1).text()).toBe("2015-06-01")
    expect(tds.eq(2).text()).toBe("")
    expect(tds.eq(3).text()).toBe("account 2")
    expect(tds.eq(4).text()).toBe("($25.00)")
    expect(tds.eq(5).text()).toBe("not_reconciled")
