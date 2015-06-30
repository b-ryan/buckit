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
    link: (scope, elem, attr) ->
      scope.form =
        date: null
        payee_id: null
        splits: [
          {
            account_id: null
            amount: 0
            reconciled_status: "not_reconciled"
          }
        ]

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
          scope.form.date = transaction.date
          scope.form.payee_id = transaction.payee_id
        , (error) ->
          alert error

      scope.save = ->
        # TODO validation

        transaction =
          date: scope.form.date
          payee_id: scope.form.payee_id
          splits: [
            {
              account_id: scope.accountId
              amount: 0
              reconciled_status: "not_reconciled"
            }
          ]

        amount_sum = 0
        for split in scope.form.splits
          transaction.splits.push split
          amount_sum += split.amount

        # FIXME probably not relevant when user explicitly entering multiple
        # splits
        transaction.splits[0].amount = -1 * amount_sum

        f = if scope.transactionId \
          then Transactions.update \
          else Transactions.save
        f(transaction).then (transaction) ->
          console.log "saved", transaction
        , (error) ->
          alert error

      elem.find('input[name="date"]')[0].focus()
]
