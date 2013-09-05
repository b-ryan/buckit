import os
import bottle

DIR = os.path.abspath(os.path.dirname(__file__))
public_dir = os.path.abspath(os.path.join(DIR, '../../public'))

@bottle.get('/public/<path:path>')
def public(path):
    return bottle.static_file(path, root=public_dir)

@bottle.get('/')
def index():
    return bottle.static_file('html/index.html', root=public_dir)

import transactions
import summaries
