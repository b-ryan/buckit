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

    $scope.setActiveTab = (index) ->
        for tab in $scope.tabs
            tab.active = false
        $scope.tabs[index].active = true

window.AccountsCtrl = ($scope, Accounts) ->

    $scope.setActiveTab(0)

    $scope.accounts = Accounts.query()

window.AccountTransactionsCtrl = (
        $scope,
        $routeParams,
        Accounts,
        AccountTransactions) ->

    $scope.setActiveTab(1)

    console.log($routeParams)

    $scope.accounts = Accounts.query()
    $scope.transactions = AccountTransactions.query({account_id: 1})

    $scope.accountTotal = (transaction) ->
        reducer = (sum, split) ->
            return sum + if split.account.name == "Credit Card" then split.amount else 0
        transaction.splits.reduce reducer, 0
