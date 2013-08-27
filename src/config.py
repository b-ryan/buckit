from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker

engine = create_engine(
  'postgresql://budget:password@127.0.0.1/budget',
  pool_recycle=3600, # recycle connections every hour
)

Session = sessionmaker(bind=engine)

port = 9000
use_reloader = True
