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

buckit.directive 'ledgerRow', (Account) ->
  restrict: 'E'
  scope:
    account: '=account'
    transaction: '=transaction'
  templateUrl: '/public/html/ledger_row.html'
  link: (scope, elem, attr) ->

    non_account_splits = (s for s in scope.transaction.splits \
      when s.account_id != scope.account.id)

    if non_account_splits.length > 1
      scope.displayAmount = 'Splits'
      scope.displayCategory = 'Splits'
    else
      split = non_account_splits[0]
      scope.displayAmount = split.amount
      scope.displayAccount = Account.get {account_id: split.account_id}

    account_split = (s for s in scope.transaction.splits \
      when s.account_id == scope.account.id)[0]

    scope.displayStatus = account_split.reconciled_status

      # <div class="row-fluid" ng-show="transaction.editing">
      #   <label class="span1">{{transaction.id}}</label>
      #   <label class="span1">{{transaction.editing}}</label>
      #   <label class="span2"><input ng-model="transaction.date"></label>
      #   <label class="span3">
      #     <select ng-model="transaction.payee"
      #             ng-options="payee.name for payee in payees">
      #     </select>
      #   </label>
      #   <label class="span3">{{transactionDestination(transaction)}}</label>
      #   <label class="span1">{{transactionAmount(transaction) | currency}}</label>
      #   <label class="span1">{{transactionStatus(transaction)}}</label>
      # </div>
