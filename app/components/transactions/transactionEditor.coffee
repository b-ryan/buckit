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

      newFormSplit = ->
          {
            accountId: null
            accountLocked: false
            description: null
            outflow: 0
            inflow: 0
          }

      scope.date = $.datepicker.formatDate(DATEPICKER_DATE_FORMAT, new Date())
      scope.payee_id = null

      scope.formSplits = [newFormSplit()]

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
          # FIXME
        , (error) ->
          alert error

      scope.outflowBlurred = (split) ->
        if split.outflow != 0
          # FIXME instead of Math.abs, warn the user / do not allow negatives
          split.outflow = Math.abs(split.outflow)
          split.inflow = 0

      scope.inflowBlurred = (split) ->
        if split.inflow != 0
          split.inflow = Math.abs(split.inflow)
          split.outflow = 0

      scope.addSplit = () ->
        # if we currently only have one formSplit, then we are entering
        # multi-split mode. FIXME more docs
        if scope.formSplits.length == 1
          scope.formSplits.push newFormSplit()
          scope.formSplits.push newFormSplit()
          scope.formSplits[1].accountId = scope.formSplits[0].accountId
          scope.formSplits[0].accountId = scope.accountId
          scope.formSplits[0].accountLocked = true
        else
          scope.formSplits.push newFormSplit()

      scope.save = ->
        if scope.form.$invalid
          scope.form.$setSubmitted()
          return

        transaction =
          date: scope.date # FIXME formatting?
          payee_id: scope.payee_id
          splits: [] # FIXME

        console.log transaction

        # f = if scope.transactionId \
        #   then Transactions.update \
        #   else Transactions.save
        # f(transaction).then (transaction) ->
        #   console.log "saved", transaction
        # , (error) ->
        #   alert error

]
