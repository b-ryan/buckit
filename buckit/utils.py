"""
This file currently contains several bits of functionality
that I don't know what to do with. I'm hoping I discover
where all of this should properly live as the project matures
"""
import json
from config import Session
import buckit.model as m

class CustomEncoder(json.JSONEncoder):

    def default(self, obj):
        if hasattr(obj, '__json__'):
            return obj.__json__()
        if hasattr(obj, '__dict__'):
            return obj.__dict__
        return str(obj)

def with_session(func):
    def wrapped(*args, **kwargs):
        session = Session()
        try:
            result = func(session, *args, **kwargs)
        finally:
            session.close()
        return result
    return wrapped

def get_ledger(session, account):
    splits = session.query(m.Split)\
        .join(m.Account)\
        .join(m.Transaction)\
        .filter(m.Account.id == account.id)\
        .order_by(m.Transaction.date.desc())\
        .all()
    return splits
