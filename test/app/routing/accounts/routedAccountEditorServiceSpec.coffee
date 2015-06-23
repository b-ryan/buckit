describe "routedAccountEditorService", ->
  service = null
  $state = null
  $rootScope = null
  $location = null
  $q = null
  accountEditorService = null

  beforeEach module "buckit.routing"

  beforeEach module(($provide) ->
    accountEditorService = jasmine.createSpyObj "accountEditorService", [
      "editWithModal"
      "cancelModal"
    ]
    $provide.value "accountEditorService", accountEditorService
    null
  )

  beforeEach inject(($injector) ->
    service = $injector.get "routedAccountEditorService"
    $state = $injector.get "$state"
    $rootScope = $injector.get "$rootScope"
    $location = $injector.get "$location"
    $q = $injector.get "$q"
  )

  it "routes back to accounts when canceling in accounts.create", ->
    p = $q.defer()
    accountEditorService.editWithModal.and.returnValue p.promise

    $state.go "accounts.create"
    $rootScope.$digest()

    expect($location.url()).toBe("/accounts/create")

    p.reject "escape key press"
    $rootScope.$digest()

    expect($location.url()).toBe("/accounts")
