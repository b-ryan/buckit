import flask
from flask.ext.sqlalchemy import SQLAlchemy
import logging
import config
import buckit.routes

app = flask.Flask(__name__, static_folder=None)
app.logger.setLevel(logging.DEBUG)

app.config['SQLALCHEMY_DATABASE_URI'] = config.db_url
db = SQLAlchemy(app)

buckit.routes.setup_routes(app, db)
