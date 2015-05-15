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

transactionTransforms = createActions
  fromBackend: (model) ->
    model.date = new Date(model.date)
    return model
  toBackend: (model) ->
    model.date = model.date.toISOString().substr(0, 10)
    return model

buckit.factory 'Api', ($resource) ->
  accounts: $resource('/api/accounts/:id', {}, defaultActions)
  payees: $resource('/api/payees/:id', {}, defaultActions)
  transactions: $resource('/api/transactions/:id', {}, transactionTransforms)
  splits: $resource('/api/splits/:id', {}, defaultActions)

buckit.factory 'Account', ($resource) ->
  $resource '/api/accounts/:id', {}, defaultActions

buckit.factory 'Payee', ($resource) ->
  $resource '/api/payees/:id', {}, defaultActions

buckit.factory 'Transaction', ($resource) ->
  $resource '/api/transactions/:id', {}, transactionTransforms

buckit.factory 'Split', ($resource) ->
  $resource '/api/splits/:id', {}, defaultActions
