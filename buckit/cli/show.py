import buckit.model
from buckit.utils import with_session

models = {
    'accounts': buckit.model.Account,
    'transactions': buckit.model.Transaction,
}

def setup_args(parser):
    parser.add_argument('model_identifier', choices=models.keys())

@with_session
def handle_args(session, args):
    model = models[args.model_identifier]
    results = session.query(model).all()
    for result in results:
        print result
