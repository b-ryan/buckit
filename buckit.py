#!/usr/bin/env python
import argparse
import buckit.cli as cli
import sys

def serve(args):
    bottle.run(port=config.port, reloader=config.use_reloader)

parser = argparse.ArgumentParser()
subs = parser.add_subparsers()

cli.add_parsers(subs)

args = parser.parse_args()

try:
    args.func(args)
except cli.common.CliException as e:
    print >> sys.stderr, e.message
    exit(1)
