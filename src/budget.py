#!/usr/bin/env python
import bottle
import argparse
import routes
import config

parser = argparse.ArgumentParser()
parser.add_argument('--migrate', action='store_true')
args = parser.parse_args()

if args.migrate:
    import model
    from model.base import Base
    Base.metadata.create_all(config.engine)
else:
    bottle.run(port=config.port, reloader=config.use_reloader)
