import importlib

modules = [
    importlib.import_module(m) for m in [
        'cli.transaction',
    ]
]

def add_parsers(parent_parser):
    [m.init_parser(parent_parser) for m in modules]
