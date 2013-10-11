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
        json = {
            'id':            self.id,
            'date':          self.date,
            'payee':         self.payee,
        }
        if include_splits:
            json['splits'] = [s.__json__(include_transaction=False) for s in self.splits]
        return json

    def __str__(self):
        payee_name = self.payee.name if self.payee else ''
        s = "Transaction id:{0} date:{1}\n".format(self.id, self.date, payee_name)
        s += "\n".join([' ' * 4 + str(split) for split in self.splits])
        return s
