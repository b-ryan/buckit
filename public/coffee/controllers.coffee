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

window.AccountTransactionsCtrl = (
        $scope,
        $routeParams,
        $location,
        $modal,
        $timeout,
        Accounts,
        AccountTransactions) ->

    $scope.setActiveTab($scope.LEDGER_TAB_INDEX)

    $scope.$watch 'currAccount', () ->
        if not $scope.currAccount
            return
        $location.path '/ledger/' + $scope.currAccount.id
        $scope.fetchTransactions()

    $scope.accounts = Accounts.query () ->
        $scope.changeCurrAccount $routeParams.account_id

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

    $scope.openTransactionModal = () ->
        modalInstance = $modal.open
            templateUrl: 'transactionModal.html'

    $scope.openDatepicker = () ->
        $timeout () ->
            $scope.datepickerOpened = true
