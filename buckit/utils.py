import json

class CustomEncoder(json.JSONEncoder):

    def default(self, obj):
        if hasattr(obj, '__json__'):
            return obj.__json__()
        if hasattr(obj, '__dict__'):
            return obj.__dict__
        return str(obj)
