import flask
from flask.ext.sqlalchemy import SQLAlchemy
import logging
import buckit.routes
import os

app = flask.Flask(__name__, static_folder=None)
app.logger.setLevel(logging.DEBUG)

db_url = 'sqlite:///{}/buckit.sqlite'.format(os.getcwd())
app.config['SQLALCHEMY_DATABASE_URI'] = db_url
db = SQLAlchemy(app)

buckit.routes.setup_routes(app, db)
