angular.module("buckit.components").directive "transactionEditor", [
  "componentUrl"
  "Transactions"
  "Accounts"
  "Payees"
  (componentUrl, Transactions, Accounts, Payees) ->
    restrict: "E"
    templateUrl: componentUrl("transactions/transactionEditor.html")
    scope:
      accountId: "="
      transactionId: "="
      onCancel: "="
      onSave: "="
    link: (scope, elem, attr) ->
      if not scope.onCancel
        throw new Error("transaction editor must have an on-cancel callback")

      if not scope.onSave
        throw new Error("transaction editor must have an on-save callback")

      DATEPICKER_DATE_FORMAT = "yy-mm-dd"

      newSplit = ->
          {
            account_id: null
            amount: 0
            reconciled_status: "not_reconciled"
          }

      scope.transBase =
        date: $.datepicker.formatDate(DATEPICKER_DATE_FORMAT, new Date())
        payee_id: null

      scope.primarySplit = newSplit()
      scope.primarySplit.account_id = scope.accountId
      scope.foreignSplits = [newSplit()]

      dateInput = elem.find("input[name='date']")
      dateInput.datepicker
        dateFormat: DATEPICKER_DATE_FORMAT

      Accounts.query().then (accounts) ->
        scope.accounts = accounts
      , (error) ->
        alert error

      Payees.query().then (payees) ->
        scope.payees = payees
      , (error) ->
        alert error

      if scope.transactionId
        Transactions.get({id: scope.transactionId}).then (transaction) ->
          console.log "Editing transaction", transaction
          scope.transBase =
            date: transaction.date # FIXME not formatted properly
            payee_id: transaction.payee_id
          # FIXME does not copy splits
        , (error) ->
          alert error

      scope.setPrimarySplitAmount = ->
        total = 0
        for s in scope.foreignSplits
          total += s.amount
        scope.primarySplit.amount = -1 * total

      scope.addForeignSplit = () ->
        scope.foreignSplits.push newSplit()

      scope.save = ->
        transaction = angular.copy(scope.transBase)
        transaction.splits = angular.copy(scope.foreignSplits)
        transaction.splits.splice(0, 0, angular.copy(scope.primarySplit))

        console.log transaction

        # f = if scope.transactionId \
        #   then Transactions.update \
        #   else Transactions.save
        # f(transaction).then (transaction) ->
        #   console.log "saved", transaction
        # , (error) ->
        #   alert error

]
