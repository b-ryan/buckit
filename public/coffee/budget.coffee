angular.module 'budget', ['ngResource'], ($routeProvider) ->
    $routeProvider
        .otherwise
            templateUrl: '/public/html/welcome.html',

.factory 'Transaction', ($resource) ->
    return $resource '/transactions/:id'
