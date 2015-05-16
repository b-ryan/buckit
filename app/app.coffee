angular.module "buckit", [
  "ngResource"
  "ui.bootstrap"
  "ui.select2"
  "ui.router"
]

angular.module("buckit").run [
  "$rootScope"
  "$state"
  "$stateParams"
  ($rootScope, $state, $stateParams) ->
    $rootScope.$state = $state
    $rootScope.$stateParams = $stateParams
]

angular.module("buckit").config [
  "$stateProvider"
  ($stateProvider) ->

    # For any unmatched url, redirect to some "unknown" state
    # This state can then have a controller which can smart-route to the
    # last known position or something like that
    # $urlRouterProvider.otherwise("/state1");

    $stateProvider
      .state "budget",
        url: "/budget"
        template: "<budget-view></budget-view>"
]
