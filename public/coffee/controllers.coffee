window.TabsCtrl = ($scope, $route, $location) ->

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

    $scope.updateActive = () ->
        for tab in $scope.tabs
            tab.active = tab.href == '#' + $location.path()

    $scope.$on '$routeChangeSuccess', $scope.updateActive

    $scope.updateActive()

window.AccountsCtrl = ($scope, Accounts) ->

    $scope.accounts = Accounts.query()

window.AccountTransactionsCtrl = ($scope, AccountTransactions) ->

    $scope.transactions = AccountTransactions.query({account_id: 1})

    $scope.accountTotal = (transaction) ->
        reducer = (sum, split) ->
            return sum + if split.account.name == "Credit Card" then split.amount else 0
        transaction.splits.reduce reducer, 0
