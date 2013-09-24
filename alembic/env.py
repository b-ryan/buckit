from alembic import context
from sqlalchemy import engine_from_config
from logging.config import fileConfig

from buckit.model.base import Base
from buckit.config import engine

fileConfig(context.config.config_file_name)

context.configure(
    connection=engine.connect(),
    target_metadata=Base.metadata,
)

try:
    with context.begin_transaction():
        context.run_migrations()
finally:
    connection.close()
