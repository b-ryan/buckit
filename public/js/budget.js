angular.module('budget', ['ngResource'], function($routeProvider) {
    $routeProvider
      .otherwise({
        templateUrl: '/public/html/welcome.html',
      });
  })

  .factory('Transaction', function($resource) {
    return $resource(
      '/transactions/:id'
      // { _id: '@_id' },
      // { update: { method: 'PUT' } }
    );
  })

  ;
