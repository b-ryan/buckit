import base
from sqlalchemy import Column, ForeignKey, Integer, Date
from sqlalchemy.orm import relationship

class Transaction(base.Base):

    __tablename__ = 'transactions'

    id         = Column(Integer, primary_key=True)
    date       = Column(Date, nullable=False)
    payee_id   = Column(Integer, ForeignKey('payees.id'))

    payee  = relationship('Payee')
    splits = relationship('Split')

    def __json__(self, include_splits=True):
        return {
            'id':     self.id,
            'date':   self.date,
            'payee':  self.payee,
            'splits': self.splits,
        }
