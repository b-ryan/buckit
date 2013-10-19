buckit.factory 'Account', ($resource) ->
    $resource '/accounts/:account_id'

buckit.factory 'Payee', ($resource) ->
    $resource '/payees/:payee_id'

buckit.factory 'Transaction', ($resource) ->
    $resource '/transactions/:id'

buckit.factory 'Split', ($resource) ->
    $resource '/splits/:id'
