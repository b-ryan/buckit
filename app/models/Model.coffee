angular.module("buckit").factory "Model", [
  "$resource"
  "$rootScope"
  ($resource, $rootScope) ->
    mkActions = (transforms) ->
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

    class Model
      constructor: (name, url, transforms) ->
        transforms ?=
          fromBackend: (model) ->
            return model
          toBackend: (model) ->
            return model

        @name = name
        @resource = $resource url, {}, mkActions(transforms)

      get: =>
        return @resource.get.apply(@, arguments).$promise

      query: =>
        return @resource.query.apply(@, arguments).$promise

      save: =>
        promise = @resource.save.apply(@, arguments).$promise
        promise.then (obj) =>
          $rootScope.$broadcast (@name + ".POST"), obj
        return promise

      update: =>
        promise = @resource.update.apply(@, arguments).$promise
        promise.then (obj) =>
          $rootScope.$broadcast (@name + ".PUT"), obj
        return promise

    return Model

]
