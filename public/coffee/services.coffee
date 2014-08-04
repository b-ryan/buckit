createActions = (transforms) ->
  get:
    method: 'GET'
    transformResponse: (data) ->
      transforms.fetch(o)
  query:
    method: 'GET'
    transformResponse: (data) ->
      objs = angular.fromJson(data).objects
      transforms.fetch(o) for o in objs
      return objs
    isArray: true
  update:
    method: 'PUT'
    params: {id: '@id'}
    transformRequest: (obj) ->
      transforms.save(obj)
      return angular.toJson(obj)
  delete:
    method: 'DELETE'
    params: {id: '@id'}

defaultActions = createActions
  fetch: (o) ->
    null
  save: (o) ->
    null

buckit.factory 'BuckitResource', ($resource) ->
  console.log 'hi'

buckit.factory 'Account', ($resource, BuckitResource) ->
  $resource '/api/accounts/:account_id', {}, defaultActions

buckit.factory 'Payee', ($resource) ->
  $resource '/api/payees/:payee_id', {}, defaultActions

buckit.factory 'Transaction', ($resource) ->
  transforms =
    fetch: (o) ->
      o.date = new Date(o.date)
    save: (o) ->
      o.date = o.date.toISOString().substr(0, 10)
  $resource '/api/transactions/:id', {}, createActions(transforms)

buckit.factory 'Split', ($resource) ->
  $resource '/api/splits/:id', {}, defaultActions

buckit.factory 'ReconciledStatus', ($resource) ->
  all: () ->
    [
      'not_reconciled'
      'cleared'
      'reconciled'
    ]
