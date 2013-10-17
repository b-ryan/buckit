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

window.NewTransactionCtrl = ($scope, $timeout, Transaction) ->

    $scope.statuses = [
        'not_reconciled'
        'cleared'
        'reconciled'
    ]

    $scope.reset = () ->
        $scope.transaction = new Transaction
            date: new Date()
            payee: null
            splits: [
                {
                    account: null
                    status: 'not_reconciled'
                    amount: 0
                }
                {
                    account: null
                    status: 'not_reconciled'
                    amount: 0
                }
            ]
        $scope.payeeName = null
        $scope.accountName = null
        $scope.amount = 0
        $scope.splitStatus = 'not_reconciled'

    findByName = (list, name) ->
        matches = list.filter (x) ->
            x.name == name
        matches[0]

    $scope.payeeNameChanged = () ->
        $scope.transaction.payee = findByName $scope.payees, $scope.payeeName

    $scope.accountNameChanged = () ->
        split = $scope.transaction.splits[1]
        split.account = findByName $scope.accounts, $scope.accountName

    $scope.$watch 'account', (account) ->
        $scope.transaction.splits[0].account = account

    $scope.$watch 'amount', (amount) ->
        $scope.transaction.splits[0].amount = amount * -1
        $scope.transaction.splits[1].amount = amount * 1

    $scope.$watch 'splitStatus', (status) ->
        $scope.transaction.splits[0].status = status

    $scope.openDatepicker = () ->
        $timeout () ->
            $scope.datepickerOpened = true

    $scope.reset()
