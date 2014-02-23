RESOURCE_ACTIONS =
    query:
        method: 'GET'
        transformResponse: (data) ->
            angular.fromJson(data).objects
        isArray: true
    update:
        method: 'PUT'
        params: {id: '@id'}
    delete:
        method: 'DELETE'
        params: {id: '@id'}

buckit.factory 'Account', ($resource) ->
    $resource '/api/accounts/:account_id', {}, RESOURCE_ACTIONS

buckit.factory 'Payee', ($resource) ->
    $resource '/api/payees/:payee_id', {}, RESOURCE_ACTIONS

buckit.factory 'Transaction', ($resource) ->
    $resource '/api/transactions/:id', {}, RESOURCE_ACTIONS

buckit.factory 'Split', ($resource) ->
    $resource '/api/splits/:id', {}, RESOURCE_ACTIONS
