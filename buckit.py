#!/usr/bin/env python
import bottle
import argparse
import buckit.routes as routes
import buckit.config as config
import buckit.cli as cli
import buckit.seed

def seed(args):
    buckit.seed.seed()

def serve(args):
    bottle.run(port=config.port, reloader=config.use_reloader)

parser = argparse.ArgumentParser()
subs = parser.add_subparsers()

subs.add_parser('seed').set_defaults(func=seed)
subs.add_parser('serve').set_defaults(func=serve)

cli.add_parsers(subs)

args = parser.parse_args()
args.func(args)
