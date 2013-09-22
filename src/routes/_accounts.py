import bottle
import config
import model
import json
from _utils import CustomEncoder

@bottle.get('/accounts')
def accounts():
    session = config.Session()
    response = json.dumps(
        session.query(model.Account)\
            .all(),
        cls=CustomEncoder,
    )
    session.close()
    bottle.response.content_type = 'application/json'
    return response
