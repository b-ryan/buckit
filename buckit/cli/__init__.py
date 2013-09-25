import importlib

modules = [
    importlib.import_module(m) for m in [
        'buckit.cli.show',
    ]
]

def add_parsers(parent_parser):
    [m.init_parser(parent_parser) for m in modules]
