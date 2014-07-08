buckit.directive 'autoComplete', ($timeout) ->
  (scope, elem, attrs) ->
    [model_name, model_attr] = attrs.autoComplete.split ':'

    scope.$watch model_name, (new_val) ->
      elem.autocomplete
        source: new_val.map (x) -> x[model_attr]
        select: () ->
          $timeout () ->
            elem.trigger 'input'
    , true

buckit.directive 'ngBlur', ($parse) ->
  (scope, elem, attr) ->
    fn = $parse attr.ngBlur
    elem.blur (event) ->
      scope.$apply () ->
        fn scope, $event: event

buckit.directive 'ledgerRow', (Account, ReconciledStatus, $timeout) ->
  restrict: 'E'
  scope:
    account: '=account'
    transaction: '=transaction'
  templateUrl: '/public/html/ledger_row.html'
  link: (scope, elem, attr) ->
    scope.reconciled_statuses = ReconciledStatus.all()

    scope.account_split = (s for s in scope.transaction.splits \
      when s.account_id == scope.account.id)[0]

    non_account_splits = (s for s in scope.transaction.splits \
      when s.account_id != scope.account.id)

    if non_account_splits.length > 1
      scope.displayCategory = 'Splits'
    else
      split = non_account_splits[0]
      Account.get {account_id: split.account_id}, (account) ->
        scope.displayCategory = account.name

    scope.ok = () ->
      scope.$apply 'transaction.editing = false'

    scope.cancel = () ->
      $timeout () ->
        scope.transaction.editing = false

# create a directive for selecting a payee ?
