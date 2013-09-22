from model import Account, Transaction, Split
import config

def seed():
    checking = Account(
        name='Primary Checking',
        type='asset',
    )

    credit_card = Account(
        name='Credit Card',
        type='liability',
    )

    groceries = Account(
        name='Groceries',
        type='expense',
    )

    transaction_1 = Transaction(
        date='2013-08-30',
        splits=[
            Split(account=credit_card, amount=-25),
            Split(account=groceries, amount=25),
        ],
    )

    transaction_2 = Transaction(
        date='2013-09-04',
        splits=[
            Split(account=credit_card, amount=-5),
            Split(account=groceries, amount=5),
        ],
    )

    transaction_3 = Transaction(
        date='2013-09-04',
        splits=[
            Split(account=checking, amount=-30),
            Split(account=credit_card, amount=30),
        ],
    )

    session = config.Session()
    session.add(transaction_1)
    session.add(transaction_2)
    session.add(transaction_3)
    session.commit()
