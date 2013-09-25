import buckit.model
import buckit.config

def list_transactions(args):
    session = buckit.config.Session()
    trs = session.query(buckit.model.Transaction).all()
    for transaction in trs:
        payee_name = transaction.payee.name if transaction.payee else ''
        print transaction.id, transaction.date, payee_name

def init_parser(parent_parser):
    parser = parent_parser.add_parser('transaction')

    subs = parser.add_subparsers()

    _list = subs.add_parser('list')
    _list.set_defaults(func=list_transactions)
    _list.add_argument('--verbose', action='store_true')