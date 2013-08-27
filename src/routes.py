import os
import bottle
import config
import model
import json

class CustomEncoder(json.JSONEncoder):

    def default(self, obj):
        if hasattr(obj, '__json__'):
            return obj.__json__()
        if hasattr(obj, '__dict__'):
            return obj.__dict__
        return str(obj)

DIR = os.path.abspath(os.path.dirname(__file__))
public_dir = os.path.abspath(os.path.join(DIR, '../public'))

@bottle.route('/public/<path:path>')
def public(path):
    return bottle.static_file(path, root=public_dir)

@bottle.route('/')
def index():
    return bottle.static_file('html/index.html', root=public_dir)

@bottle.get('/accounts')
def accounts():
    session = config.Session()
    accounts = session.query(model.Account).all()
    session.close()

    bottle.response.content_type = 'application/json'
    return json.dumps(accounts, cls=CustomEncoder)
