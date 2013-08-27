import base
from sqlalchemy import Column, Integer, String

class Account(base.Base):

  __tablename__ = 'accounts'

  id   = Column(Integer, primary_key=True)
  name = Column(String(255), nullable=False, unique=True)

  def __repr__(self):
    return "<Account ('{0}')".format(self.name)
