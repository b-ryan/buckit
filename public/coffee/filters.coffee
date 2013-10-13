buckit.filter 'transactionDestination', () ->
    (splits, account) ->
        other_splits = splits.filter (split) ->
            split.account.id != account.id
        if other_splits.length == 0
            throw new Error("Can't find any other splits!")
        else if other_splits.length > 1
            return 'Splits'
        other_splits[0].account.name

buckit.filter 'transactionTotal', () ->
    (splits, account) ->
        reducer = (sum, split) ->
            sum + if split.account.id == account.id then split.amount else 0
        splits.reduce reducer, 0
