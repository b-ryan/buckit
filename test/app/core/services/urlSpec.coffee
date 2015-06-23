describe "componentUrl service", ->
  componentUrl = null

  beforeEach module "buckit"

  beforeEach inject(($injector) ->
    componentUrl = $injector.get "componentUrl"
  )

  it "formats URLs correctly", ->
    expect(componentUrl("abc/xyz")).toEqual("/app/components/abc/xyz")
