import show

def add_parsers(parent_parser):
    p = parent_parser.add_parser('show')
    p.set_defaults(func=show.show)
    p.add_argument('object')
