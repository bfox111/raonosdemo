#!/usr/bin/env python

from setuptools import setup, find_packages
import sys
import os

# Allow to run setup.py from another directory.
os.chdir(os.path.dirname(os.path.abspath(__file__)))

# http://bugs.python.org/issue15881#msg170215
try:
    import multiprocessing
except ImportError:
    pass

version = '0.0.1.dev0'

setup(
    name='raonosdemo',
    version=version,
    url='https://github.com/bfox111/bponosdemo.git',
    license='CIENA',
    author='Barbara Fox',
    author_email='bfox@ciena.com',
    description='Blue Planet Resource Adaptor for ONOS',
    long_description="""\
Blue Planet Resource Adaptor for ONOS""",
    packages=find_packages(
        exclude=(
            '.*',
            'EGG-INFO',
            '*.egg-info',
            '_trial*',
            '*.tests',
            '*.tests.*',
            'tests.*',
            'tests',
            'examples.*',
            'examples*',
            )
        ),
    include_package_data=True,
    install_requires=[
        'cymlrest',
        'bpramodels',
        'rasdk',
        'twigjack'
        ],
    entry_points={
        'console_scripts': [
            'raonosdemo = raonosdemo.main:main',
            ]
        },
    tests_require=[
        'mock',
        'nose',
        ],
    test_suite='nose.collector',
)
