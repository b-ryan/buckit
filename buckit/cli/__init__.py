import serve
import seed
import show
import add

commands = {
    'seed':  seed,
    'serve': serve,
    'show':  show,
    'add':   add,
}

def add_parsers(parent_parser):
    for command in commands:
        p = parent_parser.add_parser(command)

        module = commands[command]

        if hasattr(module, 'handle_args'):
            p.set_defaults(func=getattr(module, 'handle_args'))

        if hasattr(module, 'setup_args'):
            getattr(module, 'setup_args')(p)
