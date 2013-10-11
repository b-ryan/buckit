buckit.factory 'Accounts', ($resource) ->
    return $resource '/accounts/:id'

buckit.factory 'AccountTransactions', ($resource) ->
    return $resource '/accounts/:account_id/transactions'
