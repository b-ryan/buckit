#!/usr/bin/env python
import argparse
import buckit.cli as cli

def serve(args):
    bottle.run(port=config.port, reloader=config.use_reloader)

parser = argparse.ArgumentParser()
subs = parser.add_subparsers()

cli.add_parsers(subs)

args = parser.parse_args()
args.func(args)
