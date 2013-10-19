window.TabsCtrl = ($scope) ->

    $scope.tabs = [
        {
            name: 'Accounts'
            href: '#/accounts'
        }
        {
            name: 'Ledger'
            href: '#/ledger'
        }
    ]

    $scope.ACCOUNTS_TAB_INDEX = 0
    $scope.LEDGER_TAB_INDEX = 1

    $scope.setActiveTab = (index) ->
        for tab in $scope.tabs
            tab.active = false
        $scope.tabs[index].active = true

window.AccountsCtrl = ($scope, Account) ->

    $scope.setActiveTab($scope.ACCOUNTS_TAB_INDEX)

    $scope.accounts = Account.query()

window.LedgerCtrl = (
        $scope,
        $routeParams,
        $location,
        $modal,
        $timeout,
        Account,
        Transaction,
        Payee) ->

    $scope.setActiveTab($scope.LEDGER_TAB_INDEX)

    $scope.accounts = Account.query () ->
        $scope.changeAccount $routeParams.account_id

    $scope.payees = Payee.query()

    $scope.$watch 'account', () ->
        if not $scope.account
            return
        $location.path '/ledger/' + $scope.account.id
        $scope.fetchTransactions()

    $scope.changeAccount = (account_id) ->
        if account_id
            match = $scope.accounts.filter (account) ->
                account.id == parseInt account_id
            $scope.account = match[0]
        else
            $scope.account = $scope.accounts[0]

    $scope.fetchTransactions = () ->
        $scope.transactions = Transaction.query
            account_id: $scope.account.id

window.NewTransactionCtrl = ($scope, $timeout, Transaction, Split) ->

    $scope.statuses = [
        'not_reconciled'
        'cleared'
        'reconciled'
    ]

    $scope.reset = () ->
        $scope.date = new Date()
        $scope.payeeName = null
        $scope.payeeId = null
        $scope.destAccountName = null
        $scope.destAccountId = null
        $scope.amount = 0
        $scope.status = 'not_reconciled'

    findByName = (list, name) ->
        matches = list.filter (x) ->
            x.name == name
        matches[0]

    $scope.updatePayeeId = () ->
        payee = findByName $scope.payees, $scope.payeeName
        $scope.payeeId = payee.id

    $scope.updateAccountId = () ->
        account = findByName $scope.accounts, $scope.destAccountName
        $scope.destAccountId = account.id

    $scope.saveTransaction = () ->
        transaction = new Transaction
            date: $scope.date
            payee_id: $scope.payeeId
            splits: [
                new Split(
                    account_id: $scope.account.id
                    amount: $scope.amount * -1
                    reconciled_status: $scope.status
                )

                new Split(
                    account_id: $scope.destAccountId
                    amount: $scope.amount * 1
                    reconciled_status: 'not_reconciled'
                )
            ]
        console.log transaction

        transaction.$save () ->
            console.log transaction

    $scope.openDatepicker = () ->
        $timeout () ->
            $scope.datepickerOpened = true

    $scope.reset()
