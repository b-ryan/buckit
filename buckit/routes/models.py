import bottle
import json
import buckit.config
import buckit.model
from buckit.utils import CustomEncoder, get_ledger

@bottle.get('/accounts')
def accounts():
    session = buckit.config.Session()
    response = json.dumps(
        session.query(buckit.model.Account)\
            .all(),
        cls=CustomEncoder,
    )
    session.close()
    bottle.response.content_type = 'application/json'
    return response

@bottle.get('/accounts/:account_id/splits')
def account_splits(account_id):
    session = buckit.config.Session()
    account = session.query(buckit.model.Account)\
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
        session.query(buckit.model.Transaction)\
            .order_by(buckit.model.Transaction.date.asc())\
            .all(),
        cls=CustomEncoder,
    )
    session.close()
    bottle.response.content_type = 'application/json'
    return response
