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

  it "GETs one correctly", ->
    $httpBackend.when("GET", "/model/123")
      .respond({key: "value"})

    p = model.get {id: 123}
    success = jasmine.createSpy()
    error = jasmine.createSpy()
    p.then success, error

    $httpBackend.flush()

    expect(error).not.toHaveBeenCalled()
    expect(success).toHaveBeenCalled()
    expect(success.calls.mostRecent().args[0].key).toEqual("value")

  it "GETs many correctly", ->
    $httpBackend.when("GET", "/model")
      .respond(
        objects: [
          {id: 1}
          {id: 2}
        ]
      )

    p = model.query()
    success = jasmine.createSpy()
    error = jasmine.createSpy()
    p.then success, error

    $httpBackend.flush()

    expect(error).not.toHaveBeenCalled()
    expect(success).toHaveBeenCalled()
    arr = success.calls.mostRecent().args[0]
    expect(arr.length).toEqual(2)
    expect(arr[0].id).toEqual(1)
    expect(arr[1].id).toEqual(2)

  it "POSTs correctly", ->
    $httpBackend.when("POST", "/model", {name: "Bork"})
      .respond(
        id: 44
        name: "Bork"
      )

    p = model.save({name: "Bork"})
    success = jasmine.createSpy()
    error = jasmine.createSpy()
    p.then success, error

    $httpBackend.flush()

    expect(error).not.toHaveBeenCalled()
    expect(success).toHaveBeenCalled()
    obj = success.calls.mostRecent().args[0]
    expect(obj.id).toEqual(44)
    expect(obj.name).toEqual("Bork")

  it "PUTs correctly", ->
    $httpBackend.when("PUT", "/model/23", {id: 23, name: "Bork"})
      .respond(
        id: 23
        name: "Bork"
      )

    p = model.update({id: 23, name: "Bork"})
    success = jasmine.createSpy()
    error = jasmine.createSpy()
    p.then success, error

    $httpBackend.flush()

    expect(error).not.toHaveBeenCalled()
    expect(success).toHaveBeenCalled()
    obj = success.calls.mostRecent().args[0]
    expect(obj.id).toEqual(23)
    expect(obj.name).toEqual("Bork")

  it "throws errors correctly", ->
    $httpBackend.when("GET", "/model/123")
      .respond(500, {msg: "here is an error"})

    p = model.get {id: 123}
    success = jasmine.createSpy()
    error = jasmine.createSpy()
    p.then success, error

    $httpBackend.flush()

    expect(success).not.toHaveBeenCalled()
    expect(error).toHaveBeenCalled()
    expect(error.calls.mostRecent().args[0].data.msg).toEqual("here is an error")
