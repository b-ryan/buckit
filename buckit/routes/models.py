import bottle
import json
import buckit.config
import buckit.model
from buckit.utils import CustomEncoder

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
