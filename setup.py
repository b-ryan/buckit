#!/usr/bin/env python
from setuptools import setup, find_packages, Command
import os.path

package_name = "buckit"
package_version = "0.0.0"

setup(
    name=package_name,
    version=package_version,
    packages=find_packages(),
    scripts=[
        "scripts/buckit_seed.py",
    ],
    install_requires=[
        "alembic",
        "flask",
        "flask-cors",
        "flask-sqlalchemy",
        "flask-restless",
        "python-dateutil",
        "sqlalchemy",
    ],
)
