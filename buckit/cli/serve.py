import buckit.routes as routes
import buckit.config as config
import bottle

def serve(args):
    bottle.run(port=config.port, reloader=config.use_reloader)
