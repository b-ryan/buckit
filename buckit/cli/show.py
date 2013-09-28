import buckit.model
from buckit.utils import with_session

models = {
    'accounts':     buckit.model.Account,
    'payees':       buckit.model.Payee,
    'transactions': buckit.model.Transaction,
}

def setup_parser(parent_parser):
    parser = parent_parser.add_parser('show')
    parser.set_defaults(func=show)
    parser.add_argument('model_identifier', choices=models.keys())

@with_session
def show(session, args):
    model = models[args.model_identifier]
    results = session.query(model).all()
    for result in results:
        print result
