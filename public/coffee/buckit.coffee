buckit = angular.module 'buckit', ['ngResource'],
    ($routeProvider) ->
        $routeProvider
            .when '/accounts',
                templateUrl: '/public/html/accounts.html'
            .when '/Ledger',
                templateUrl: '/public/html/ledger.html'

buckit.factory 'Transaction', ($resource) ->
    return $resource '/transactions/:id'

buckit.factory 'Account', ($resource) ->
    return $resource '/accounts/:id'

window.buckit = buckit
