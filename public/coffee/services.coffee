buckit.factory 'Account', ($resource) ->
    return $resource '/accounts/:id'

buckit.factory 'Split', ($resource) ->
    return $resource '/accounts/:account_id/splits'

buckit.factory 'Transaction', ($resource) ->
    return $resource '/transactions/:id'
