import serve
import seed
import show
import add

def add_parsers(parent_parser):
    parent_parser.add_parser('seed')\
        .set_defaults(func=seed.seed)

    parent_parser.add_parser('serve')\
        .set_defaults(func=serve.serve)

    p = parent_parser.add_parser('show')
    p.set_defaults(func=show.show)
    p.add_argument('object')

    p = parent_parser.add_parser('add')
    p.set_defaults(func=add.add)
    p.add_argument('object')
