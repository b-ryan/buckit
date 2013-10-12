buckit.filter 'transactionTotal', () ->
    (splits, account_id) ->
        reducer = (sum, split) ->
            sum + if split.account.id == account_id then split.amount else 0
        splits.reduce reducer, 0
