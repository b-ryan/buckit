#!/usr/bin/env python
from buckit.app import app
import subprocess
import sys

if __name__ == '__main__':
    subprocess.Popen(['coffee', '-cwo', 'public/.compiled/', 'public/coffee'],
                     stdout=sys.stdout, stderr=sys.stderr)

    app.static_folder = '../public'

    @app.route('/', defaults={'filename': 'index.html'})
    @app.route('/public/<path:filename>')
    def static(filename):
        return app.send_static_file(filename)

    app.run(debug=True, port=8080)
