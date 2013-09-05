budget = angular.module 'budget', ['ngResource']

budget.factory 'Transaction', ($resource) ->
    return $resource '/transactions/:id'

budget.factory 'Account', ($resource) ->
    return $resource '/accounts/:id'

window.budget = budget
