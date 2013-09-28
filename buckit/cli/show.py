import common
import buckit.model as m
from buckit.utils import with_session
from sqlalchemy.orm import joinedload

def setup_parser(parent_parser):
    parser = parent_parser.add_parser('show')
    subs = parser.add_subparsers()

    p = subs.add_parser('accounts')
    p.set_defaults(func=show, model=m.Account)

    p = subs.add_parser('payees')
    p.set_defaults(func=show, model=m.Payee)

    p = subs.add_parser('transactions')
    p.add_argument('--account', required=True)
    p.set_defaults(func=show_transactions)

@with_session
def show(session, args):
    results = session.query(args.model).all()
    for result in results:
        print result

def print_table(table, has_header=True):
    if len(table) == 0:
        return

    columns = zip(*table)
    max_values = [max(col, key=len) for col in columns]
    widths = [len(x) for x in max_values]

    if has_header:
        table.insert(1, ['-' * x for x in widths])

    fmt = ' | '.join(('{:<' + str(width) + '}' for width in widths))
    for row in table:
        print fmt.format(*row)

@with_session
def show_transactions(session, args):
    account = common.search_by_name(session, m.Account, args.account)

    table = [('id', 'date', 'payee', 'to_account', 'amount')]
    for split in account.splits:
        transaction = split.transaction
        table.append((
            str(transaction.id),
            str(transaction.date),
            transaction.payee.name if transaction.payee else '',
            split.account.name,
            str(split.amount),
        ))

    print_table(table)
