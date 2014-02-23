import base
from sqlalchemy import Column, ForeignKey, Integer, Enum, Float
from sqlalchemy.orm import relationship
from sqlalchemy.schema import UniqueConstraint

ReconciledStatus = Enum(
    'not_reconciled',
    'cleared',
    'reconciled',
    name='reconciled_status',
)

class Split(base.Base):

    __tablename__ = 'transaction_splits'

    id                 = Column(Integer, primary_key=True)
    transaction_id     = Column(Integer, ForeignKey('transactions.id'), nullable=False)
    account_id         = Column(Integer, ForeignKey('accounts.id'), nullable=False)
    amount             = Column(Float, default=0.)
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
