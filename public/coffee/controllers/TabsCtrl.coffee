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
