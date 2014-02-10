import base
from sqlalchemy import Column, Integer, String

class Payee(base.Base):

    __tablename__ = 'payees'

    id        = Column(Integer, primary_key=True)
    name      = Column(String(255), nullable=False, unique=True)
