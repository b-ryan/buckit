#!/usr/bin/env python
from buckit.app import app

if __name__ == '__main__':
    app.static_folder = '../app'

    @app.route('/', defaults={'filename': 'index.html'})
    @app.route('/app/<path:filename>')
    def static(filename):
        return app.send_static_file(filename)

    app.run(debug=True, port=8080)
