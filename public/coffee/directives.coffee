buckit.directive 'autoComplete', ($timeout) ->
    (scope, elem, attrs) ->
        [model_name, model_attr] = attrs.autoComplete.split ':'

        scope.$watch model_name, (new_val) ->
            elem.autocomplete
                source: new_val.map (x) -> x[model_attr]
                select: () ->
                    $timeout () ->
                        elem.trigger 'input'
        , true
