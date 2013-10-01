window.AccountsCtrl = ($scope, Account) ->

    $scope.accounts = Account.query()

window.TransactionsCtrl = ($scope, Transaction) ->

    $scope.transactions = Transaction.query()

    $scope.reset = () ->
        $scope.transaction = new Transaction
            status: 'not_reconciled'

    $scope.save = (transaction) ->
        console.log(transaction)
        $scope.reset()

    $scope.reset()
