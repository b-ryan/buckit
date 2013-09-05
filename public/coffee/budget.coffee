budget = angular.module 'budget', ['ngResource']

budget.factory 'Transaction', ($resource) ->
    return $resource '/transactions/:id'

window.budget = budget
