describe "Model factory", ->
  $httpBackend = null
  model = null

  beforeEach module("buckit")

  beforeEach inject(($injector) ->
    $httpBackend = $injector.get '$httpBackend'
    Model = $injector.get('Model')
    model = new Model("ModelName", "/model/:id")
  )

  afterEach ->
    $httpBackend.verifyNoOutstandingExpectation()
    $httpBackend.verifyNoOutstandingRequest()

  it "GETs correctly", ->
    $httpBackend.when("GET", "/model/123")
      .respond({key: "value"})

    p = model.get {id: 123}
    resolve = jasmine.createSpy()
    p.then resolve

    $httpBackend.flush()

    expect(resolve).toHaveBeenCalled()
    expect(resolve.calls.mostRecent().args[0].key).toEqual("value")
