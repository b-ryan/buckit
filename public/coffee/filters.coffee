buckit.filter 'transactionTotal', () ->
    (splits, account) ->
        reducer = (sum, split) ->
            sum + if split.account.id == account.id then split.amount else 0
        splits.reduce reducer, 0
