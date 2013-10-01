import common
import buckit.model as m
from buckit.utils import with_session
from sqlalchemy.orm import joinedload
import table_print

def setup_parser(parent_parser):
    p = parent_parser.add_parser('accounts')
    p.set_defaults(func=show, model=m.Account)

    p = parent_parser.add_parser('payees')
    p.set_defaults(func=show, model=m.Payee)

    p = parent_parser.add_parser('ledger')
    p.add_argument('--account', '-a', required=True)
    p.set_defaults(func=show_ledger)

@with_session
def show(session, args):
    results = session.query(args.model).all()
    for result in results:
        print result

@with_session
def show_ledger(session, args):
    account = common.search_by_name(session, m.Account, args.account)
    splits = session.query(m.Split)\
        .join(m.Account)\
        .join(m.Transaction)\
        .filter(m.Account.name == args.account)\
        .order_by(m.Transaction.date.desc())\
        .all()

    table = [('id', 'date', 'payee', 'amount')]
    for split in splits:
        transaction = split.transaction
        table.append((
            str(transaction.id),
            str(transaction.date),
            transaction.payee.name if transaction.payee else '',
            str(split.amount),
        ))

    table_print.p(table)
