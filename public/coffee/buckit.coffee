buckit = angular.module 'buckit', [
    'ngRoute'
    'ngResource'
    'ui.bootstrap'
    'ui.select2'
  ],
  ($routeProvider) ->
    $routeProvider
      .when '/accounts',
        templateUrl: '/public/html/accounts.html'
      .when '/ledger',
        templateUrl: '/public/html/ledger.html'
      .when '/ledger/:account_id',
        templateUrl: '/public/html/ledger.html'
      .otherwise
        templateUrl: '/public/html/main.html'

window.buckit = buckit
