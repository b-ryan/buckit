import model
import config

def list_transactions(args):
    session = config.Session()
    trs = session.query(model.Transaction).all()
    print trs

def init_parser(parent_parser):
    parser = parent_parser.add_parser('transaction')

    subs = parser.add_subparsers()

    _list = subs.add_parser('list')
    _list.set_defaults(func=list_transactions)
    _list.add_argument('--verbose', action='store_true')
