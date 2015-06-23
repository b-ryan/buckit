describe "routedAccountEditorService", ->
  service = null
  $state = null
  $rootScope = null
  $location = null
  $q = null
  deferred = null
  accountEditorService = null

  beforeEach module("buckit.routing")

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

    deferred = $q.defer()
    accountEditorService.editWithModal.and.returnValue deferred.promise
  )

  it "from accounts.create, cancel goes to accounts", ->
    $state.go "accounts.create"
    $rootScope.$digest()

    expect($location.url()).toBe("/accounts/create")

    deferred.reject "escape key press"
    $rootScope.$digest()

    expect($location.url()).toBe("/accounts")

  it "from accounts.details.create, cancel goes to accounts.details", ->
    $state.go "accounts.details.create", {accountId: 1}
    $rootScope.$digest()

    expect($location.url()).toBe("/accounts/1/create")

    deferred.reject "escape key press"
    $rootScope.$digest()

    expect($location.url()).toBe("/accounts/1")

  it "from accounts.create, success goes to accounts.details", ->
    $state.go "accounts.create"
    $rootScope.$digest()

    expect($location.url()).toBe("/accounts/create")

    deferred.resolve {id: 1}
    $rootScope.$digest()

    expect($location.url()).toBe("/accounts/1")
