buckit.factory 'Account', ($resource) ->
    return $resource '/accounts/:id'

buckit.factory 'Transaction', ($resource) ->
    return $resource '/transactions/:id'
