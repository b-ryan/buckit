buckit.directive 'ngBlur', ($parse) ->
  (scope, elem, attr) ->
    fn = $parse attr.ngBlur
    elem.blur (event) ->
      scope.$apply () ->
        fn scope, $event: event
