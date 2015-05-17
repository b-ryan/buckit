angular.module("buckit").directive "ledgerRow", [
  ->
    restrict: "A"
    require: "^ledger"
    scope: true
    link: (scope, elem, attr, ledgerCtrl) ->
      account = ledgerCtrl.getActiveAccount()
      transaction = scope[attr.transaction]

      scope.primarySplit = null
      scope.secondarySplits = []

      for split in transaction.splits
        if split.account_id == account.id
          scope.primarySplit = split
        else
          scope.secondarySplits.push split

      scope.categoryToDisplay = ->
        if scope.secondarySplits.length > 1
          return "Splits"

        foreignAccountId = scope.secondarySplits[0].account_id
        return ledgerCtrl.getAccountById(foreignAccountId).name
]
