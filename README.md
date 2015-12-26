# budget

A self-hosted budgeting app.

![circleci status](https://circleci.com/gh/b-ryan/buckit.png?style=shield&circle-token=6479cec582723fb5dbee4f5b262e10f2a12ad6bc)

## Setup

```bash
sudo apt-get install python-virtualenv
sudo apt-get install virtualenvwrapper
sudo apt-get install inotify-tools

mkvirtualenv buckit
pip install -r requirements.txt
pip install -r dev_requirements.txt

# create the database
psql
CREATE ROLE buckit LOGIN ENCRYPTED PASSWORD 'password';
CREATE DATABASE buckit OWNER buckit;
\q

alembic upgrade head
```

## Running

workon buckit
./devserver.py

## TODO

- unit testing
- API documentation
- better installation instructions
- distributable package
