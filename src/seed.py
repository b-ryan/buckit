import model
import config

def seed():
    session = config.Session()

    checking = model.Account(
        name='Primary Checking',
        type='asset',
    )

    groceries = model.Account(
        name='Groceries',
        type='expense',
    )

    splits = [
        model.Split(account=checking, amount=-25),
        model.Split(account=groceries, amount=25),
    ]

    trans1 = model.Transaction(
        date='2013-08-30',
        status='not_reconciled',
        splits=splits,
    )

    session.add(trans1)
    session.commit()
