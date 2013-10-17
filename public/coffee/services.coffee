buckit.factory 'Account', ($resource) ->
    $resource '/accounts/:account_id'

buckit.factory 'AccountTransaction', ($resource) ->
    $resource '/accounts/:account_id/transactions'

buckit.factory 'Payee', ($resource) ->
    $resource '/payees/:payee_id'

buckit.factory 'Transaction', ($resource) ->
    $resource '/transactions/:id'
