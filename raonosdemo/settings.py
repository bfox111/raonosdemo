#!/usr/bin/env python
# Copyright(c) 2014, Cyan, Inc. All rights reserved.

import os

DEFAULT_CONFIG_DIRPATH = os.path.join(os.path.dirname(__file__), 'config/dev')
DEFAULT_PORT = 8080

RA_NAME = 'raonosdemo'

BPPROV_MODEL_DIRPATH = os.path.join(os.path.dirname(__file__), 'model')

TYPE_GROUP = 'ONOS'

RESOURCE_TYPES = ['ONOS', ]

ENDPOINTS = ['rest', ]

SYNCHRONIZERS = ()

VENDOR = 'Ciena'

AUTHOR = 'Barbara A. Fox'

STATIC_PATHS = {
        '/images/': os.path.join(os.path.dirname(__file__), 'model/graphics/images'),
            }
