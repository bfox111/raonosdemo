#!/usr/bin/env python
# -*- coding: UTF-8 -*-
# Copyright(c) 2014, Cyan, Inc. All rights reserved.

from rasdk.conf import settings

from raonosdemo.main import main
from mock import patch

import unittest


class test_main(unittest.TestCase):

    def tearDown(self):
        settings._configured = False

    @patch('raonosdemo.main.argparse')
    @patch('raonosdemo.main.setupDaemonLogging')
    @patch('raonosdemo.main.setupLogging')
    @patch('raonosdemo.main.Controller')
    @patch('raonosdemo.main.reactor')
    def test_main(self, reactor, Controller, sL, sDL, argparse):
        main()


if __name__ == "__main__":
    unittest.main()
