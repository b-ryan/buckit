window.AccountsCtrl = ($scope, Account) ->

  $scope.setActiveTab($scope.ACCOUNTS_TAB_INDEX)

  $scope.accounts = Account.query()
