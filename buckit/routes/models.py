import bottle
import json
import buckit.config
import buckit.model as m
from buckit.utils import CustomEncoder, get_ledger

def with_session(func):
    def wrapped(*args, **kwargs):
        bottle.request.session = buckit.config.Session()
        ret = None
        try:
            ret = func(*args, **kwargs)
        finally:
            bottle.request.session.close()
        return ret
    return wrapped

def _json(func):
    def wrapped(*args, **kwargs):
        bottle.response.content_type = 'application/json'
        return json.dumps(func(*args, **kwargs), cls=CustomEncoder)
    return wrapped

@bottle.get('/accounts')
@with_session
@_json
def accounts():
    return bottle.request.session.query(m.Account)\
        .all()

@bottle.get('/accounts/:account_id')
@with_session
@_json
def accounts(account_id):
    return bottle.request.session.query(m.Account)\
        .filter_by(id=account_id)\
        .first()

@bottle.get('/accounts/:account_id/transactions')
@with_session
@_json
def account_transactions(account_id):
    return bottle.request.session.query(m.Transaction)\
        .join(m.Split)\
        .join(m.Account)\
        .filter(m.Account.id == account_id)\
        .order_by(m.Transaction.date.desc())\
        .all()

@bottle.get('/accounts/:account_id/splits')
def account_splits(account_id):
    session = buckit.config.Session()
    account = session.query(m.Account)\
        .filter_by(id=account_id)\
        .first()
    response = json.dumps(
        get_ledger(session, account),
        cls=CustomEncoder,
    )
    session.close()
    bottle.response.content_type = 'application/json'
    return response

@bottle.get('/transactions')
def transactions():
    session = buckit.config.Session()
    response = json.dumps(
        session.query(m.Transaction)\
            .order_by(m.Transaction.date.asc())\
            .all(),
        cls=CustomEncoder,
    )
    session.close()
    bottle.response.content_type = 'application/json'
    return response
