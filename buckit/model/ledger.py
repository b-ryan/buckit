import base
from account import Account
from transaction import Transaction
from split import Split
from sqlalchemy import join
from sqlalchemy.orm import column_property

accounts_table = Account.__table__
transactions_table = Transaction.__table__
splits_table = Split.__table__

class Ledger(base.Base):

    __table__ = join(accounts_table, splits_table)

    id = column_property(accounts_table.c.id, splits_table.c.account_id)
