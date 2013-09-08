import model
import config

def seed():
    session = config.Session()

    account = model.Account(
        name='Primary Checking',
        type='
    )

    splits = [
        model.Split(amount=23),
        model.Split(amount=0.5),
    ]
    trans1 = model.Transaction(
        account=account,
        date='2013-08-30',
        status='not_reconciled',
        splits=splits,
    )

    session.add(account)
    session.add(trans1)
    session.commit()
