createActions = (transforms) ->
  get:
    method: 'GET'
    params: {id: '@id'}
    isArray: false
    transformResponse: (json) ->
      transforms.fromBackend(angular.fromJson(json))
  query:
    method: 'GET'
    isArray: true
    transformResponse: (json) ->
      (transforms.fromBackend(m) for m in angular.fromJson(json).objects)
  update:
    method: 'PUT'
    params: {id: '@id'}
    transformRequest: (model) ->
      return angular.toJson(transforms.toBackend(model))
  delete:
    method: 'DELETE'
    params: {id: '@id'}

defaultActions = createActions
  fromBackend: (model) ->
    return model
  toBackend: (model) ->
    return model

buckit.factory 'Account', ($resource) ->
  $resource '/api/accounts/:id', {}, defaultActions

buckit.factory 'Payee', ($resource) ->
  $resource '/api/payees/:id', {}, defaultActions

buckit.factory 'Transaction', ($resource) ->
  transforms =
    fromBackend: (model) ->
      model.date = new Date(model.date)
      return model
    toBackend: (model) ->
      model.date = model.date.toISOString().substr(0, 10)
      return model
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
