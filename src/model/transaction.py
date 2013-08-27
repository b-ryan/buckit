import base
from sqlalchemy import Column, ForeignKey, Integer, DateTime, Enum

TransactionStatus = Enum(
    'not_reconciled',
    'cleared',
    'reconciled',
    name='transaction_status',
)

class Transaction(base.Base):

    __tablename__ = 'transactions'

    id         = Column(Integer, primary_key=True)
    account_id = Column(Integer, ForeignKey('accounts.id'))
    datetime   = Column(DateTime, nullable=False)
    status     = Column(TransactionStatus)

    def __repr__(self):
        return "<Transaction ('{0}')".format(self.id)
