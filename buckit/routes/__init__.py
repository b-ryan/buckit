from flask.ext.restless import APIManager
from buckit.app import app, db
import buckit.model as m

api = APIManager(app, flask_sqlalchemy_db=db)

api.create_api(
    m.Account,
    methods=['GET'],
    results_per_page=None,
)
