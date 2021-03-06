from alembic import context
from functools import partial
from sqlalchemy import engine_from_config
from logging.config import fileConfig

import os.path as path
import sys

curr_dir = path.abspath(path.dirname(__file__))
sys.path.append(path.join(curr_dir, '..'))

from buckit.models import Base
import buckit.app

app = buckit.app.create()

fileConfig(context.config.config_file_name)

# render_as_batch allows SQLite migrations to work.
configure_context = partial(context.configure, render_as_batch=True)

def run_migrations_offline():
    """Run migrations in 'offline' mode.

    This configures the context with just a URL
    and not an Engine, though an Engine is acceptable
    here as well.  By skipping the Engine creation
    we don't even need a DBAPI to be available.

    Calls to context.execute() here emit the given string to the
    script output.

    """
    configure_context(url=app.db.engine.url)

    with context.begin_transaction():
        context.run_migrations()

def run_migrations_online():
    """Run migrations in 'online' mode.

    In this scenario we need to create an Engine
    and associate a connection with the context.

    """
    connection = app.db.engine.connect()

    configure_context(
        connection=connection,
        target_metadata=Base.metadata,
    )

    try:
        with context.begin_transaction():
            context.run_migrations()
    finally:
        connection.close()

if context.is_offline_mode():
    run_migrations_offline()
else:
    run_migrations_online()

