#!/usr/bin/env python
import buckit.app
import buckit.models as m
import datetime
import sys

SUCCESS = 0
FAILURE = 1


def confirm():
    ans = raw_input("This will wipe the database; are you sure? [yN] ")
    if ans and ans in "yY":
        return True
    return False


def main():
    if not confirm():
        return FAILURE

    app = buckit.app.create()
    session = app.db.session

    for tbl in [m.Split, m.Transaction, m.Payee, m.Account]:
        session.query(tbl).delete()

    checking = m.Account(name="Checking", type="asset")
    savings = m.Account(name="Savings", type="asset")
    groceries = m.Account(name="Groceries", type="expense")

    grocery_store = m.Payee(name="Grocery Store")

    # paid for groceries with checking account
    t1 = m.Transaction(
        date=datetime.date.today(),
        payee=grocery_store,
        splits=[
            m.Split(
                account=checking,
                amount=-20.52,
            ),
            m.Split(
                account=groceries,
                amount=20.52,
            ),
        ],
    )

    # transfer from savings into checking
    t2 = m.Transaction(
        date=datetime.date.today(),
        splits=[
            m.Split(
                account=checking,
                amount=88,
                is_primary_split=True,
            ),
            m.Split(
                account=savings,
                amount=-88,
            ),
        ],
    )

    # split transaction; took some money from checking, sent it to savings and
    # towards groceries
    t3 = m.Transaction(
        date=datetime.date.today(),
        payee=grocery_store,
        splits=[
            m.Split(
                account=checking,
                amount=-10,
            ),
            m.Split(
                account=savings,
                amount=5,
                is_primary_split=True,
            ),
            m.Split(
                account=groceries,
                amount=5,
            ),
        ],
    )

    for x in [checking, savings, groceries, grocery_store, t1, t2, t3]:
        session.add(x)

    session.commit()

    return SUCCESS

if __name__ == "__main__":
    sys.exit(main())
