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
    date       = Column(Date, nullable=False)
    status     = Column(TransactionStatus)

    splits = relationship('Split')

    @property
    def total_amount(self):
        return sum([split.amount for split in self.splits])

    def __json__(self):
        return {
            'id':            self.id,
            'date':          self.date,
            'status':        self.status,
            'splits':        self.splits,
            'total_amount':  self.total_amount,
        }

    def __repr__(self):
        return "<Transaction ('{0}')".format(self.id)

class Split(base.Base):
    '''Splits describe where money is coming from and where it's going. A
    transaction will always be set up like this:

    TODO: Should individual splits be cleared/reconciled??
    '''

    __tablename__ = 'transaction_splits'

    id             = Column(Integer, primary_key=True)
    transaction_id = Column(Integer, ForeignKey('transactions.id'))
    account_id     = Column(Integer, ForeignKey('accounts.id'))
    amount         = Column(Float)

    account = relationship('Account')

    def __json__(self):
        return {
            'id':      self.id,
            'account': self.account,
            'amount':  self.amount,
        }

    def __repr__(self):
        return "<Split ('{0}')>".format(self.amount)
