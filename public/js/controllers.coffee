window.TransactionsCtrl = ($scope, Transaction) ->

    $scope.transactions = Transaction.query()
