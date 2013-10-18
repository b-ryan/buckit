import base
from sqlalchemy import Column, ForeignKey, Integer, Date
from sqlalchemy.orm import relationship
from dateutil import parser
from payee import Payee
from split import Split

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

    @staticmethod
    def from_json(json):
        print json

        id = json.get('id', None)
        date = parser.parse(json['date']).date()
        payee = Payee.from_json(json['payee']) \
            if json.get('payee', None) \
            else None
        splits = [Split.from_json(split) for split in json['splits']]

        return Transaction(
            id=id,
            date=date,
            payee=payee,
            splits=splits,
        )
