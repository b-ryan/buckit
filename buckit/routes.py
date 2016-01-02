import buckit.models as m
from flask.ext.restless import APIManager
import time


def _delay(blueprint, seconds=3):
    """Causes the request to be slow. Should only be used while developing."""
    blueprint.before_request(lambda: time.sleep(seconds))


def _fail(blueprint):
    """Causes the request to fail. Should only be used while developing."""
    def raise_it():
        raise Exception()
    blueprint.before_request(raise_it)


def initialize(app):
    api = APIManager(app, flask_sqlalchemy_db=app.db)

    blueprints = [
        api.create_api_blueprint(
            m.Account,
            methods=['GET', 'POST', 'PUT'],
            results_per_page=None,
        ),
        api.create_api_blueprint(
            m.Payee,
            methods=['GET', 'POST'],
            results_per_page=None,
        ),
        api.create_api_blueprint(
            m.Transaction,
            methods=['GET', 'POST', 'PUT'],
            results_per_page=25,
        ),
    ]

    map(app.register_blueprint, blueprints)
