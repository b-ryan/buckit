describe "something", ->
  it "is false", ->
    beforeEach(module("buckit"))

    beforeEach inject((_$compile_, $rootScope) ->
      console.log _$compile_
    )

    # expect(1).toEqual(2)
