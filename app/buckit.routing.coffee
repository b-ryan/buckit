angular.module "buckit.routing", [
  "buckit.core"
  "buckit.components"
  "ui.router"
]

angular.module("buckit.routing").run [
  "$rootScope"
  "$state"
  "$stateParams"
  ($rootScope, $state, $stateParams) ->
    $rootScope.$state = $state
    $rootScope.$stateParams = $stateParams
]

angular.module("buckit.routing").config [
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
