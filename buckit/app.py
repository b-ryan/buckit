import buckit.routes
import flask
from flask.ext.cors import CORS
from flask.ext.sqlalchemy import SQLAlchemy
import logging
import os

def create():
    app = flask.Flask(__name__, static_folder=None)
    app.logger.setLevel(logging.DEBUG)

    CORS(app)

    db_url = 'sqlite:///{}/buckit.sqlite'.format(os.getcwd())
    app.config['SQLALCHEMY_DATABASE_URI'] = db_url
    app.db = SQLAlchemy(app)

    buckit.routes.initialize(app)
    return app
