# budget

A self-hosted budgeting app.

## Setup

```bash
sudo apt-get install python-virtualenv
sudo apt-get install virtualenvwrapper
mkvirtualenv buckit
pip install -r requirements.txt
pip install -r dev_requirements.txt

## npm (Ubuntu 13.10/14.04)
sudo apt-get install nodejs npm nodejs-legacy
npm install coffee-script
echo 'export PATH=$PATH:node_modules/.bin' >> ~/.bashrc.local
```

## Running

coffee -cwo public/.compiled public/coffee
src/budget --serve
