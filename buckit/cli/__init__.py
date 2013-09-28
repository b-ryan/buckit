import importlib

modules = [
    importlib.import_module(m) for m in [
        'buckit.cli.show',
        'buckit.cli.add',
        'buckit.cli.serve',
        'buckit.cli.seed',
    ]
]

def add_parsers(parent_parser):
    [m.setup_parser(parent_parser) for m in modules]
