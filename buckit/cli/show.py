import buckit.model
from buckit.config import Session

models = {
    'accounts': buckit.model.Account,
    'transactions': buckit.model.Transaction,
}

def show(args):
    session = Session()
    results = session.query(args.model).all()
    for result in results:
        print result

def init_parser(parent_parser):
    parser = parent_parser.add_parser('show')

    subs = parser.add_subparsers()

    for model_name in models:
        sub_parser = subs.add_parser(model_name)
        sub_parser.set_defaults(
            func=show,
            model=models[model_name],
        )
