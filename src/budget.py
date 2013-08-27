#!/usr/bin/env python
import bottle
import argparse
import routes

parser = argparse.ArgumentParser()
parser.add_argument('--migrate', action='store_true')
args = parser.parse_args()

if args.migrate:
    import model
    from model.base import Base
    import db
    Base.metadata.create_all(db.engine)
else:
    bottle.run(port=9000, reloader=True)
