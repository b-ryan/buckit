import buckit.models as m
from flask.ext.restless import APIManager


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
            results_per_page=None,
        ),
        api.create_api_blueprint(
            m.Split,
            methods=['POST'],
            results_per_page=None,
        ),
    ]

    map(app.register_blueprint, blueprints)
