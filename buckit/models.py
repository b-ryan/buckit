from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy import (
    Boolean,
    Column,
    Date,
    Enum,
    Float,
    Integer,
    ForeignKey,
    String,
)
from sqlalchemy import select, func
from sqlalchemy.orm import relationship, column_property
from sqlalchemy.schema import Index, UniqueConstraint

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

    __tablename__ = 'splits'

    id = Column(Integer, primary_key=True)
    transaction_id = Column(Integer, ForeignKey('transactions.id'),
                            nullable=False)
    account_id = Column(Integer, ForeignKey('accounts.id'),
                        nullable=False)
    amount = Column(Float, default=0.)
    reconciled_status = Column(ReconciledStatus, default='not_reconciled')
    is_primary_split = Column(Boolean, default=0)

    transaction = relationship('Transaction', lazy=False)
    account = relationship('Account')

    __table_args__ = (
        UniqueConstraint(
            'transaction_id',
            'account_id',
            name='transaction__account__uix',
        ),
    )

# The following creates a unique constraint on the 'splits' table for the
# combination of (transaction_id, is_primary_split), but only where
# is_primary_split is not 0. This allows us to ensure only 1 split per
# transaction is marked as the primary split. This takes advantage of the
# "partial index" feature provided by sqlite and postgresql. MySQL does not
# have this feature.
primary_split_uix_where = Split.is_primary_split != 0
Index(
    'transaction__primary_split__uix',
    Split.transaction_id,
    Split.is_primary_split,
    unique=True,
    postgresql_where=primary_split_uix_where,
    sqlite_where=primary_split_uix_where,
)

Account.balance = column_property(
    select([func.sum(Split.amount)]).
    where(Account.id == Split.account_id)
)
