from buckit.model import Account, Payee, Transaction, Split
import buckit.config

def seed():
    supermarket = Payee(
        name='Supermarket',
    )

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

    groceries_purchase_1 = Transaction(
        date='2013-08-30',
        payee=supermarket,
        splits=[
            Split(account=credit_card, amount=-25),
            Split(account=groceries, amount=25),
        ],
    )

    groceries_purchase_2 = Transaction(
        date='2013-09-04',
        payee=supermarket,
        splits=[
            Split(account=credit_card, amount=-5),
            Split(account=groceries, amount=5),
        ],
    )

    credit_card_payment = Transaction(
        date='2013-09-04',
        splits=[
            Split(account=checking, amount=-30),
            Split(account=credit_card, amount=30),
        ],
    )

    session = buckit.config.Session()
    session.add(groceries_purchase_1)
    session.add(groceries_purchase_2)
    session.add(credit_card_payment)
    session.commit()
