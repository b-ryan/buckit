# TODO use routing to separate the parent ledger from this stuff
# maybe look into the angular router project
window.TransactionCtrl = ($scope, Account, Transaction) ->

  for s in $scope.transaction.splits
    Account.get {id: s.account_id}, (account) ->
      s.account = account

  $scope.editing = false

  $scope.account_split = (s for s in $scope.transaction.splits \
    when s.account_id == $scope.account.id)[0]

  $scope.non_account_splits = (s for s in $scope.transaction.splits \
    when s.account_id != $scope.account.id)

  $scope.edit = () ->
    $scope.editing = true

