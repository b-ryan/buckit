buckit = angular.module 'buckit', ['ngResource']

buckit.factory 'Transaction', ($resource) ->
    return $resource '/transactions/:id'

buckit.factory 'Account', ($resource) ->
    return $resource '/accounts/:id'

window.buckit = buckit
