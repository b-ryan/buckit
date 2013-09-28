import base
from sqlalchemy import Column, Integer, String

class Payee(base.Base):

    __tablename__ = 'payees'

    id        = Column(Integer, primary_key=True)
    name      = Column(String(255), nullable=False, unique=True)

    def __json__(self):
        return {
            'id':   self.id,
            'name': self.name,
        }

    def __str__(self):
        return "Payee id:{0} name:{1}".format(self.id, self.name)
