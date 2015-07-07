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

      scope.formVals =
        date: null
        payee_id: null
        splits: [
          {
            account_id: scope.accountId
            amount: 0
            reconciled_status: "not_reconciled"
            locked: true
          }
          {
            account_id: null
            amount: 0
            reconciled_status: "not_reconciled"
            locked: false
          }
        ]

      scope.datepicker =
        isOpen: false

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

      scope.openDatepicker = ($event) ->
        $event.preventDefault()
        $event.stopPropagation()
        scope.datepicker.isOpen = true

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

        amount_sum = 0
        for split in scope.formVals.splits
          transaction.splits.push split
          amount_sum += split.amount

        # FIXME probably not relevant when user explicitly entering multiple
        # splits
        transaction.splits[0].amount = -1 * amount_sum

        console.log transaction

        f = if scope.transactionId \
          then Transactions.update \
          else Transactions.save
        f(transaction).then (transaction) ->
          console.log "saved", transaction
        , (error) ->
          alert error

      elem.find('input[name="date"]')[0].focus()
]
