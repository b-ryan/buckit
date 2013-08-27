import base
from sqlalchemy import Column, ForeignKey, Integer, Float

class Split(base.Base):

    __tablename__ = 'splits'

    id             = Column(Integer, primary_key=True)
    transaction_id = Column(Integer, ForeignKey('transactions.id'))
    amount         = Column(Float)

    def __repr__(self):
        return "<Split ('{0}')>".format(self.amount)
