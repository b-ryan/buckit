# budget

A self-hosted budgeting app.

![circleci status](https://circleci.com/gh/b-ryan/buckit.png?style=shield&circle-token=900699d95e7b0250798d7b9756b9747f4fd0789b)

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
