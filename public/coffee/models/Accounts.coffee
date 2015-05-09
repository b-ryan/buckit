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

buckit.factory 'Accounts', ($resource) ->
  $resource '/api/accounts/:id', {}, defaultActions
