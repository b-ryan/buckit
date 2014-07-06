window.TabsCtrl = ($scope, Account) ->

  $scope.accountsTab =
      name: 'Accounts'
      href: '#/accounts'

  $scope.ledgerTab =
      name: 'Ledger'
      href: '#/ledger'

  $scope.ACCOUNTS_TAB_INDEX = 0
  $scope.LEDGER_TAB_INDEX = 1
  $scope.tabs = [$scope.accountsTab, $scope.ledgerTab]

  $scope.setActiveTab = (index) ->
    for tab in $scope.tabs
      tab.active = false
    $scope.tabs[index].active = true

  $scope.accounts = Account.query()
