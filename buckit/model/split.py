import base
from sqlalchemy import Column, ForeignKey, Integer, Enum, Float
from sqlalchemy.orm import relationship

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

    account     = relationship('Account')
    transaction = relationship('Transaction', lazy=False)

    def __json__(self, include_transaction=True):
        json = {
            'id':                self.id,
            'account':           self.account,
            'amount':            self.amount,
            'reconciled_status': self.reconciled_status,
        }
        if include_transaction:
            json['transaction'] = self.transaction.__json__(include_splits=False)
        return json

    def __str__(self):
        return "Split id:{0} account:{1} amount:{2}".format(
            self.id,
            self.account.name,
            self.amount,
        )
