#!/usr/bin/env python
import buckit.app

if __name__ == '__main__':
    app = buckit.app.create()
    app.static_folder = '../app'

    @app.route('/', defaults={'filename': 'index.html'})
    @app.route('/app/<path:filename>')
    def static(filename):
        return app.send_static_file(filename)

    app.run(debug=True, host="0.0.0.0", port=8080)
