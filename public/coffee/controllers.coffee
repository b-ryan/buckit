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

window.AccountsCtrl = ($scope, Accounts) ->

    $scope.setActiveTab($scope.ACCOUNTS_TAB_INDEX)

    $scope.accounts = Accounts.query()

window.LedgerCtrl = (
        $scope,
        $routeParams,
        $location,
        $modal,
        $timeout,
        Accounts,
        AccountTransactions,
        Payees) ->

    $scope.setActiveTab($scope.LEDGER_TAB_INDEX)

    $scope.accounts = Accounts.query () ->
        $scope.changeAccount $routeParams.account_id

    $scope.payees = Payees.query()

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
        $scope.transactions = AccountTransactions.query
            account_id: $scope.account.id

window.NewTransactionCtrl = ($scope, $timeout) ->

    $scope.statuses = [
        'not_reconciled'
        'cleared'
        'reconciled'
    ]

    $scope.reset = () ->
        $scope.transaction =
            date: new Date()
        $scope.payeeName = null
        $scope.accountName = null
        $scope.amount = 0

    $scope.payeeNameChanged = () ->
        console.log $scope.payeeName

    $scope.accountNameChanged = () ->
        console.log $scope.accountName

    $scope.openDatepicker = () ->
        $timeout () ->
            $scope.datepickerOpened = true

    $scope.reset()
