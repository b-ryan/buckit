from flask.ext.restless import APIManager
import buckit.models as m


def setup_routes(app, db):
    api = APIManager(app, flask_sqlalchemy_db=db)
    api.create_api(m.Account, methods=['GET', 'POST'], results_per_page=None)
    api.create_api(m.Payee, methods=['GET'], results_per_page=None)
    api.create_api(m.Transaction, methods=['GET', 'POST', 'PUT'],
                   results_per_page=None)
    api.create_api(m.Split, methods=['POST'], results_per_page=None)
