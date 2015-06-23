describe "accountEditorService", ->
  $httpBackend = null
  service = null
  $rootScope = null

  beforeEach module "buckit.components"
  beforeEach module "buckit.templates"

  beforeEach inject(($injector) ->
    $httpBackend = $injector.get "$httpBackend"
    service = $injector.get "accountEditorService"
    $rootScope = $injector.get "$rootScope"
  )

  afterEach ->
    $httpBackend.verifyNoOutstandingExpectation()
    $httpBackend.verifyNoOutstandingRequest()

  it "cancels correctly", ->
    promise = service.editWithModal null

    $rootScope.$digest()

    success = jasmine.createSpy("success")
    error = jasmine.createSpy("error")

    promise.then success, error
    service.cancelModal()

    $rootScope.$digest()

    expect(success).not.toHaveBeenCalled()
    expect(error).toHaveBeenCalledWith("cancel function called")
