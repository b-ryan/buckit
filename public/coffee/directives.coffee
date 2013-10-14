buckit.directive 'autoComplete', ($timeout) ->
    (scope, elem, attrs) ->
        # console.log attrs.autoComplete
        scope.$watch 'accounts', (accounts) ->
            console.log elem
            elem.autocomplete
                source: accounts.map (a) -> a.name
                select: () ->
                    $timeout () ->
                        elem.trigger 'input'
        , true


# directive('autoComplete', function($timeout) {
#     return function(scope, iElement, iAttrs) {
#             iElement.autocomplete({
#                 source: scope[iAttrs.uiItems],
#                 select: function() {
#                     $timeout(function() {
#                       iElement.trigger('input');
#                     }, 0);
#                 }
#             });
#     };
# });
