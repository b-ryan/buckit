import base
from sqlalchemy import Column, ForeignKey, Integer, Date, Enum, Float
from sqlalchemy.orm import relationship

class Transaction(base.Base):

    __tablename__ = 'transactions'

    id         = Column(Integer, primary_key=True)
    date       = Column(Date, nullable=False)
    payee_id   = Column(Integer, ForeignKey('payees.id'))

    payee  = relationship('Payee')
    splits = relationship('Split')

    @property
    def total_amount(self):
        return sum([split.amount for split in self.splits])

    def __json__(self):
        return {
            'id':            self.id,
            'date':          self.date,
            'payee':         self.payee,
            'splits':        self.splits,
            'total_amount':  self.total_amount,
        }

ReconciledStatus = Enum(
    'not_reconciled',
    'cleared',
    'reconciled',
    name='reconciled_status',
)

class Split(base.Base):
    '''Splits describe where money is coming from and where it's going. A
    transaction will always be set up like this:

    TODO: Should individual splits be cleared/reconciled??
    '''

    __tablename__ = 'transaction_splits'

    id                 = Column(Integer, primary_key=True)
    transaction_id     = Column(Integer, ForeignKey('transactions.id'))
    account_id         = Column(Integer, ForeignKey('accounts.id'))
    amount             = Column(Float)
    reconciled_status  = Column(ReconciledStatus, default='not_reconciled')

    account = relationship('Account')

    def __json__(self):
        return {
            'id':                self.id,
            'account':           self.account,
            'amount':            self.amount,
            'reconciled_status': self.reconciled_status,
        }
