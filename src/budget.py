#!/usr/bin/env python
import os, sys
import bottle

DIR = os.path.abspath(os.path.dirname(__file__))
public_dir = os.path.abspath(os.path.join(DIR, '../public'))

@bottle.route('/public/<path:path>')
def public(path):
    return bottle.static_file(path, root=public_dir)

@bottle.route('/')
def index():
    return bottle.static_file('html/index.html', root=public_dir)

bottle.run(port=9000, reloader=True)
