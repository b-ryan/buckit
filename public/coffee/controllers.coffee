window.TransactionsCtrl = ($scope, Account, Transaction) ->

    $scope.accounts = Account.query()
    $scope.transactions = Transaction.query()

    $scope.reset = () ->
        $scope.transaction = new Transaction
            status: 'not_reconciled'

    $scope.save = (transaction) ->
        console.log(transaction)
        $scope.reset()

    $scope.reset()
