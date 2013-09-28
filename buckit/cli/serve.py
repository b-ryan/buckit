import buckit.routes as routes
import buckit.config as config
import bottle

def setup_parser(parent_parser):
    parser = parent_parser.add_parser('serve')
    parser.set_defaults(func=serve)

def serve(args):
    bottle.run(port=config.port, reloader=config.use_reloader)
