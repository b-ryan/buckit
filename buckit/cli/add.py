import common
from buckit.config import date_format
from buckit.utils import with_session
import buckit.model as m
from datetime import date, datetime

def setup_parser(parent_parser):
    parser = parent_parser.add_parser('add')
    subs = parser.add_subparsers()

    p = subs.add_parser('transaction')
    p.add_argument('--date', '-d',
        default=date.today().strftime(date_format),
    )
    p.add_argument('--payee', '-p')
    p.add_argument('--account', '-a', required=True)
    p.add_argument('--to-account', '-t', required=True)
    p.add_argument('--amount', '-x', required=True, type=float)
    p.set_defaults(func=add_transaction)

@with_session
def add_transaction(session, args):
    transaction = m.Transaction()

    try:
        transaction.date = datetime.strptime(args.date, date_format).date()
    except ValueError:
        raise common.CliException('Invalid date format')

    if args.payee:
        transaction.payee = common.search_by_name(session, m.Payee, args.payee)

    account = common.search_by_name(session, m.Account, args.account)
    to_account = common.search_by_name(session, m.Account, args.to_account)

    transaction.splits = [
        m.Split(account=account, amount=args.amount * -1),
        m.Split(account=to_account, amount=args.amount),
    ]

    session.add(transaction)
    session.commit()

    print transaction
