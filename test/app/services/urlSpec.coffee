describe "componentUrl service", ->
  beforeEach(module("buckit"))

  componentUrl = null

  beforeEach inject((_componentUrl_) ->
    componentUrl = _componentUrl_
  )

  it "is false", ->
    expect(componentUrl("abc/xyz")).toEqual("/app/components/abc/xyz")
