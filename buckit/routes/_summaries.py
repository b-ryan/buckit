import bottle
import json
from sqlalchemy import func
import buckit.config
from buckit.model import Transaction
from _utils import CustomEncoder

@bottle.get('/summary')
def transactions():
    session = buckit.config.Session()
    response = json.dumps(
        session.query(Transaction, func.sum(Transaction.total_amount))\
            .group_by(Transaction.date)\
            .order_by(Transaction.date.desc())\
            .all(),
        cls=CustomEncoder,
    )
    session.close()
    bottle.response.content_type = 'application/json'
    return response
