import json
from config import Session

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
