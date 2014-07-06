window.TabsCtrl = ($scope, $modal, Account) ->

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

  $scope.isAssetOrLiability = (account) ->
    account.type == 'asset' or account.type == 'liability'

  $scope.create_account = () ->
    modalInstance = $modal.open
      templateUrl: '/public/html/new_account.html'
      controller: 'NewAccountCtrl'

    modalInstance.result.then (new_account) ->
      new_account.$save (result) ->
        $scope.accounts.push result
