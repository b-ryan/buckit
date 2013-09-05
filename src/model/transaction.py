import base
from sqlalchemy import Column, ForeignKey, Integer, Date, Enum, Float
from sqlalchemy.orm import relationship

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
    date       = Column(Date, nullable=False)
    status     = Column(TransactionStatus)

    account = relationship('Account')
    splits = relationship('Split')

    @property
    def total_amount(self):
        return sum([split.amount for split in self.splits])

    def __json__(self):
        return {
            'id':            self.id,
            'account':       self.account,
            'date':          self.date,
            'status':        self.status,
            'splits':        self.splits,
            'total_amount':  self.total_amount,
        }

    def __repr__(self):
        return "<Transaction ('{0}')".format(self.id)

class Split(base.Base):

    __tablename__ = 'transaction_splits'

    id             = Column(Integer, primary_key=True)
    transaction_id = Column(Integer, ForeignKey('transactions.id'))
    amount         = Column(Float)

    def __json__(self):
        return {
            'id':      self.id,
            'amount':  self.amount,
        }

    def __repr__(self):
        return "<Split ('{0}')>".format(self.amount)
