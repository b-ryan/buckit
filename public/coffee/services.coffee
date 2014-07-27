noop = (o) ->
  null

createResourceActions = (transform) ->
  query:
    method: 'GET'
    transformResponse: (data) ->
      objs = angular.fromJson(data).objects
      transform(o) for o in objs
      return objs
    isArray: true
  update:
    method: 'PUT'
    params: {id: '@id'}
  delete:
    method: 'DELETE'
    params: {id: '@id'}

buckit.factory 'Account', ($resource) ->
  $resource '/api/accounts/:account_id', {}, createResourceActions(noop)

buckit.factory 'Payee', ($resource) ->
  $resource '/api/payees/:payee_id', {}, createResourceActions(noop)

buckit.factory 'Transaction', ($resource) ->
  r = $resource '/api/transactions/:id', {}, createResourceActions(noop)

  r.prototype.splitForAccount = (account) ->
    (s for s in this.splits when s.account_id == account.id)[0]
  r.prototype.splitsExcludingAccount = (account) ->
    (s for s in this.splits when s.account_id != account.id)

  return r

buckit.factory 'Split', ($resource) ->
  $resource '/api/splits/:id', {}, createResourceActions(noop)

buckit.factory 'ReconciledStatus', ($resource) ->
  all: () ->
    [
      'not_reconciled'
      'cleared'
      'reconciled'
    ]
