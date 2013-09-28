import exception
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
    p.add_argument('--from-account', '-f', required=True)
    p.add_argument('--to-account', '-t', required=True)
    p.add_argument('--amount', '-a', required=True)
    p.set_defaults(func=add_transaction)

def search_by_name(session, model, name):
    result = session.query(model).filter_by(name=name).first()
    if result is not None:
        return result
    raise exception.CliException('Unknown: ' + name)

@with_session
def add_transaction(session, args):
    transaction = m.Transaction()

    try:
        transaction.date = datetime.strptime(args.date, date_format).date()
    except ValueError:
        raise exception.CliException('Invalid date format')

    if args.payee:
        transaction.payee = search_by_name(session, m.Payee, args.payee)

    from_account = search_by_name(session, m.Account, args.from_account)
    to_account = search_by_name(session, m.Account, args.to_account)

    transaction.splits = [
        m.Split(account=from_account, amount=float(args.amount) * -1),
        m.Split(account=to_account,   amount=float(args.amount)),
    ]

    session.add(transaction)
    session.commit()

    print transaction
