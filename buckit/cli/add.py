import exception
from buckit.config import date_format
from buckit.utils import with_session
import buckit.model as m
import datetime

def setup_args(parser):
    subs = parser.add_subparsers()

    p = subs.add_parser('transaction')
    p.add_argument('--date', '-d',
        default=datetime.date.today().strftime(date_format),
    )
    p.add_argument('--payee', '-p')
    p.set_defaults(func=add_transaction)

@with_session
def add_transaction(session, args):
    try:
        date = datetime.datetime.strptime(args.date, date_format).date()
    except ValueError:
        msg = 'Invalid date format'
        raise exception.CliException(msg)

    payee = None
    if args.payee is not None:
        payee = session.query(m.Payee).filter_by(name=args.payee).first()
        if payee is None:
            raise exception.CliException('Unknown payee ' + args.payee)

    print date
    print payee
