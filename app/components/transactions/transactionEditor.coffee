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

      newSplit = ->
          {
            account_id: null
            amount: 0
            reconciled_status: "not_reconciled"
            isPrimarySplit: false
          }

      scope.formVals =
        date: null
        payee_id: null
        splits: [newSplit(), newSplit()]

      scope.formVals.splits[0].account_id = scope.accountId
      scope.formVals.splits[0].isPrimarySplit = true

      dateInput = elem.find("input[name='date']")
      dateInput.datepicker
        dateFormat: "yy-mm-dd"

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
          scope.formVals.date = transaction.date
          scope.formVals.payee_id = transaction.payee_id
        , (error) ->
          alert error

      scope.splitAmountUpdated = ->
        primarySplit = scope.formVals.splits[0]
        total = 0
        for s in scope.formVals.splits[1..]
          total += s.amount
        primarySplit.amount = -1 * total

      scope.addSplit = () ->
        scope.formVals.splits.push newSplit()

      scope.cancel = ->
        scope.onCancel()

      scope.save = ->
        # TODO validation

        transaction =
          date: scope.formVals.date
          payee_id: scope.formVals.payee_id
          splits: [
            {
              account_id: scope.accountId
              amount: 0
              reconciled_status: "not_reconciled"
            }
          ]

        console.log transaction

        # f = if scope.transactionId \
        #   then Transactions.update \
        #   else Transactions.save
        # f(transaction).then (transaction) ->
        #   console.log "saved", transaction
        # , (error) ->
        #   alert error

]
