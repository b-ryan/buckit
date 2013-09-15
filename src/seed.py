import model
import config

def seed():

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
        splits=splits,
    )

    session = config.Session()
    session.add(trans1)
    session.commit()
