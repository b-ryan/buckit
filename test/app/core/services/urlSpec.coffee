describe "componentUrl service", ->
  componentUrl = null

  beforeEach module("buckit")

  beforeEach inject(($injector) ->
    componentUrl = $injector.get "componentUrl"
  )

  it "is false", ->
    expect(componentUrl("abc/xyz")).toEqual("/app/components/abc/xyz")
