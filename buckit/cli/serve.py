import buckit.routes as routes
import buckit.config as config
import bottle

def handle_args(args):
    bottle.run(port=config.port, reloader=config.use_reloader)
