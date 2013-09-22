import bottle
import config
import model
import json
from _utils import CustomEncoder

@bottle.get('/transactions')
def transactions():
    session = config.Session()
    response = json.dumps(
        session.query(model.Transaction)\
            .order_by(model.Transaction.date.asc())\
            .all(),
        cls=CustomEncoder,
    )
    session.close()
    bottle.response.content_type = 'application/json'
    return response
