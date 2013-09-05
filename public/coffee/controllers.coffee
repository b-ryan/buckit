window.TransactionsCtrl = ($scope, Transaction) ->

    $scope.transactions = Transaction.query()
    $scope.transaction = new Transaction()

    $scope.save = (transaction) ->
        console.log(transaction)
        $scope.transaction = new Transaction()
