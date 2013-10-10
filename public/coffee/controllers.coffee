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

window.AccountsCtrl = ($scope, Account) ->

    $scope.accounts = Account.query()

window.LedgerCtrl = ($scope, Transaction, Split) ->

    $scope.transactions = Split.query({account_id: 1})

# not currently used
window.TransactionsCtrl = ($scope, Transaction) ->

    $scope.transactions = Transaction.query()

    $scope.reset = () ->
        $scope.transaction = new Transaction
            status: 'not_reconciled'

    $scope.save = (transaction) ->
        console.log(transaction)
        $scope.reset()

    $scope.reset()
