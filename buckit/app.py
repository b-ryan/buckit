import buckit.routes
import flask
import flask.ext.cors as cors
from flask.ext.sqlalchemy import SQLAlchemy
import logging
import os

def create():
    app = flask.Flask(__name__, static_folder=None)
    app.logger.setLevel(logging.DEBUG)

    cors.CORS(app)

    db_url = 'sqlite:///{}/buckit.sqlite'.format(os.getcwd())
    app.config['SQLALCHEMY_DATABASE_URI'] = db_url
    app.db = SQLAlchemy(app)

    buckit.routes.initialize(app)
    return app
