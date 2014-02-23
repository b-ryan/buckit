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
