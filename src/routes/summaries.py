import bottle
import config
import json
import model
from _utils import CustomEncoder
from sqlalchemy import func

@bottle.get('/summary')
def transactions():
    session = config.Session()
    response = json.dumps(
        session.query(model.Transaction, func.sum(model.Transaction.total_amount))\
            .group_by(model.Transaction.date)\
            .order_by(model.Transaction.date.desc())\
            .all(),
        cls=CustomEncoder,
    )
    session.close()
    bottle.response.content_type = 'application/json'
    return response
