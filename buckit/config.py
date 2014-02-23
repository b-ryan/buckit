from sqlalchemy import create_engine
from sqlalchemy.orm import scoped_session, sessionmaker

db_url = 'postgresql://buckit:password@127.0.0.1/buckit'

## a format interpertable by the datetime.datetime library (eg. by the
## strftime function)
date_format = '%Y-%m-%d'
