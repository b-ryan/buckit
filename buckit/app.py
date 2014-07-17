import flask
from flask.ext.sqlalchemy import SQLAlchemy
import logging
import buckit.routes

app = flask.Flask(__name__, static_folder=None)
app.logger.setLevel(logging.DEBUG)

# db_url = 'postgresql://buckit:password@127.0.0.1/buckit'
db_url = 'sqlite:///buckit.sqlite'
app.config['SQLALCHEMY_DATABASE_URI'] = db_url
db = SQLAlchemy(app)

buckit.routes.setup_routes(app, db)
