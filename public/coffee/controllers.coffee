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
        $scope.changeCurrAccount $routeParams.account_id

    $scope.payees = Payees.query()

    $scope.$watch 'currAccount', () ->
        if not $scope.currAccount
            return
        $location.path '/ledger/' + $scope.currAccount.id
        $scope.fetchTransactions()

    $scope.changeCurrAccount = (account_id) ->
        if account_id
            match = $scope.accounts.filter (account) ->
                account.id == parseInt account_id
            $scope.currAccount = match[0]
        else
            $scope.currAccount = $scope.accounts[0]

    $scope.fetchTransactions = () ->
        $scope.transactions = AccountTransactions.query
            account_id: $scope.currAccount.id

window.NewTransactionCtrl = ($scope) ->

    $scope.statuses = [
        'not_reconciled'
        'cleared'
        'reconciled'
    ]

    $scope.reset = () ->
        $scope.transaction =
            date: new Date()
            splits: []

    $scope.openDatepicker = () ->
        $timeout () ->
            $scope.datepickerOpened = true

    $scope.reset()
