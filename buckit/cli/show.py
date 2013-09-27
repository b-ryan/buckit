import buckit.model
from buckit.utils import with_session

models = {
    'accounts': buckit.model.Account,
    'transactions': buckit.model.Transaction,
    'splits': buckit.model.Split,
}

@with_session
def show(session, args):
    model = models[args.object]
    results = session.query(model).all()
    for result in results:
        print result
