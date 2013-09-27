from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker

db_url = 'postgresql://buckit:password@127.0.0.1/buckit'

engine = create_engine(
    db_url,
    pool_recycle=3600, # recycle connections every hour
)

Session = sessionmaker(bind=engine)

port = 9000
use_reloader = True

## a format interpertable by the datetime.datetime library (eg. by the
## strftime function)
date_format = '%Y-%m-%d'
