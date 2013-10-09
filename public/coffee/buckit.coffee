buckit = angular.module 'buckit', ['ngResource'],
    ($routeProvider) ->
        $routeProvider
            .when '/accounts',
                templateUrl: '/public/html/accounts.html'
            .when '/ledger',
                templateUrl: '/public/html/ledger.html'

window.buckit = buckit
