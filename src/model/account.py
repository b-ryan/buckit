import base
from sqlalchemy import Column, ForeignKey, Integer, String, Enum
from sqlalchemy.orm import relationship

"""Accounts encompass the concepts of both actual accounts, such as a
checking or savings account, and categories, which can be either
expense or income.
"""

AccountType = Enum(
    'liability', # like a credit card
    'asset', # like a bank account
    'income', # 'account' where money is entering your possession
    'expense', # 'account' where money leaves your possession
    'equity', # like stocks or options
    name='account_type',
)

class Account(base.Base):

    __tablename__ = 'accounts'

    id        = Column(Integer, primary_key=True)
    parent_id = Column(Integer, ForeignKey('accounts.id'))
    name      = Column(String(255), nullable=False, unique=True)
    type      = Column(AccountType, nullable=False)

    parent_account = relationship('Account')

    def __json__(self):
        return {
            'id':   self.id,
            'name': self.name,
        }

    def __repr__(self):
        return "<Account ('{0}')".format(self.name)
