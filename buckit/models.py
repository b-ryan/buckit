from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy import Column, ForeignKey, Integer, String, Enum, Float, Date
from sqlalchemy.orm import relationship
from sqlalchemy.schema import UniqueConstraint

Base = declarative_base()

AccountType = Enum(
    'liability',  # like a credit card
    'asset',  # like a bank account
    'income',  # 'account' where money is entering your possession
    'expense',  # 'account' where money leaves your possession
    'equity',  # like stocks or options
    name='account_type',
)


class Account(Base):
    """
    Accounts encompass the concepts of both actual accounts, such as a
    checking or savings account, and categories, which can be either
    expense or income.
    """

    __tablename__ = 'accounts'

    id = Column(Integer, primary_key=True)
    parent_id = Column(Integer, ForeignKey('accounts.id'))
    name = Column(String(255), nullable=False, unique=True)
    type = Column(AccountType, nullable=False)

    parent_account = relationship('Account')
    splits = relationship('Split')

ReconciledStatus = Enum(
    'not_reconciled',
    'cleared',
    'reconciled',
    name='reconciled_status',
)


class Payee(Base):

    __tablename__ = 'payees'

    id = Column(Integer, primary_key=True)
    name = Column(String(255), nullable=False, unique=True)


class Transaction(Base):

    __tablename__ = 'transactions'

    id = Column(Integer, primary_key=True)
    date = Column(Date, nullable=False)
    payee_id = Column(Integer, ForeignKey('payees.id'))

    payee = relationship('Payee')
    splits = relationship('Split')


class Split(Base):

    __tablename__ = 'transaction_splits'

    id = Column(Integer, primary_key=True)
    transaction_id = Column(Integer, ForeignKey('transactions.id'),
                            nullable=False)
    account_id = Column(Integer, ForeignKey('accounts.id'),
                        nullable=False)
    amount = Column(Float, default=0.)
    reconciled_status = Column(ReconciledStatus, default='not_reconciled')

    account = relationship('Account')
    transaction = relationship('Transaction', lazy=False)

    __table_args__ = (
        UniqueConstraint(
            'transaction_id',
            'account_id',
            name='transaction_splits_tran_acc_uix',
        ),
    )
