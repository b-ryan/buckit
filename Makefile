default: server

server:
	bower install
	coffee -cwo public/.compiled/ public &
	./devserver.py
