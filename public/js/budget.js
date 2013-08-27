var KEY_ENTER = 13;

angular.module('budget', ['ngResource'], function($routeProvider) {
    $routeProvider
      .when('/accounts/:_id', {
        templateUrl: '/public/html/accounts.html',
        controller: TransactionListCtrl,
      })
      .otherwise({
        templateUrl: '/public/html/welcome.html',
      });
  })
  .factory('Transaction', function($resource) {
    return $resource(
      '/transactions/:_id',
      { _id: '@_id' },
      { update: { method: 'PUT' } }
    );
  })
  .factory('Account', function($resource) {
    return $resource(
      '/accounts/:_id',
      { _id: '@_id' },
      { update: { method: 'PUT' } }
    );
  })
  .directive('ngEnter', function() {
    return function(scope, elem, attrs) {
      elem.bind('keypress', function(ev) {
        if(ev.charCode === KEY_ENTER)
          scope.$apply(attrs.ngEnter);
      });
    };
  })
  .directive('ngBlur', function() {
    return {
      restrict: 'A',
      link: function(scope, elem, attrs) {
        elem.blur(function(ev) {
          scope.$apply(attrs.ngBlur);
          return true;
        });
      },
    };
  })
  .directive('datepicker', function() {
    return {
      require: 'ngModel',
      link: function(scope, elem, attrs, ngModel) {
        var onSelect = function(value) {
          scope.$apply(function() {
            ngModel.$setViewValue(value);
          });
        };
        elem.datepicker({
          dateFormat: 'yy-mm-dd',
          onSelect: onSelect,
        });
      },
    };
  })
  ;

var TransactionListCtrl = function($scope, $routeParams, $location, Account, Transaction) {

  $scope.STATUSES = [
    'Not Reconciled',
    'Cleared',
    'Reconciled',
  ];

  $scope.accounts = Account.query();
  $scope.activeAccountId = $routeParams._id;

  $scope.transactions = Transaction.query();

  $scope.remove = function(transaction) {
    var index = null;
    for(var i = 0; i < $scope.transactions.length; i++) {
      if($scope.transactions[i]._id == transaction._id) {
        index = i;
      }
    }
    transaction.$delete(function() {
      if(index !== null)
        $scope.transactions.remove(index);
    });
  };

  $scope.update = function(transaction) {
    transaction.$update();
  };

  $scope.create = function() {
    var newTransaction = new Transaction({
      account: 'Primary Checking',
    });
    newTransaction.$save(function(transaction) {
      $scope.transactions.push(transaction);
    });
  };

  $scope.setActive = function(account) {
    $scope.activeAccountId = account._id;
    $location.url('/accounts/' + account._id);
  };

};

// Array Remove - By John Resig (MIT Licensed)
Array.prototype.remove = function(from, to) {
  var rest = this.slice((to || from) + 1 || this.length);
  this.length = from < 0 ? this.length + from : from;
  return this.push.apply(this, rest);
};
