buckit.factory 'Accounts', ($resource) ->
    $resource '/accounts/:account_id'

buckit.factory 'AccountTransactions', ($resource) ->
    $resource '/accounts/:account_id/transactions'

buckit.factory 'Payees', ($resource) ->
    $resource '/payees/:payee_id'

buckit.factory 'Transactions', ($resource) ->
    $resource '/transactions/:id'
