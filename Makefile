default: server

server:
	bower install
	coffee -cwo public/.compiled/ public/coffee &
	./devserver.py
