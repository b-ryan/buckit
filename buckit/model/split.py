import base
from sqlalchemy import Column, ForeignKey, Integer, Enum, Float
from sqlalchemy.orm import relationship
from sqlalchemy.schema import UniqueConstraint
from account import Account

ReconciledStatus = Enum(
    'not_reconciled',
    'cleared',
    'reconciled',
    name='reconciled_status',
)

class Split(base.Base):

    __tablename__ = 'transaction_splits'

    id                 = Column(Integer, primary_key=True)
    transaction_id     = Column(Integer, ForeignKey('transactions.id'))
    account_id         = Column(Integer, ForeignKey('accounts.id'))
    amount             = Column(Float)
    reconciled_status  = Column(ReconciledStatus, default='not_reconciled')

    account     = relationship('Account')
    transaction = relationship('Transaction', lazy=False)

    __table_args__ = (
        UniqueConstraint(
            'transaction_id',
            'account_id',
            name='transaction_splits_tran_acc_uix',
        ),
    )

    def __json__(self, include_transaction=True):
        return {
            'id':                self.id,
            'account':           self.account,
            'amount':            self.amount,
            'reconciled_status': self.reconciled_status,
        }

    @staticmethod
    def from_json(json):
        return Split(
            id=json.get('id', None),
            account=Account.from_json(json['account']),
            amount=float(json['amount']),
            reconciled_status=json.get('reconciled_status', 'not_reconciled'),
        )
