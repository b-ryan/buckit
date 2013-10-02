window.TabsCtrl = ($scope) ->

    $scope.tabs = 
    $scope.tabs = [
        {
            name: 'History',
            href: '#/deploys',
        },
    ];

    $scope.apps = AppService.query();

    $scope.clearClass = function(items) {
        angular.forEach(items, function(item) {
            item.class = '';
        });
    };

    $scope.$on('$routeChangeSuccess', function() {
        $scope.clearClass($scope.tabs);
        $scope.clearClass($scope.apps);

        var currentRoute = $route.current.$route;
        if(currentRoute) {
            var templateUrl = currentRoute.templateUrl;
            if(templateUrl == '/public/html/app.html') {
                angular.forEach($scope.apps, function(app) {
                    if(app.id == $route.current.params.id)
                        app.class = 'active';
                });
            }
            else if(templateUrl == '/public/html/deploys.html'
                || templateUrl == '/public/html/deploy_details.html')
                $scope.tabs[0].class = 'active';
        }
    });

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
