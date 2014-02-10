import base
from sqlalchemy import Column, ForeignKey, Integer, Date
from sqlalchemy.orm import relationship
from dateutil import parser as dateparser

class Transaction(base.Base):

    __tablename__ = 'transactions'

    id         = Column(Integer, primary_key=True)
    date       = Column(Date, nullable=False)
    payee_id   = Column(Integer, ForeignKey('payees.id'))

    payee  = relationship('Payee')
    splits = relationship('Split')
