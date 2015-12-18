#
# Module: Makefile
#
# Copyright(c) 2014, Cyan, Inc. All rights reserved.
#

HIDE ?= @
VENV := env
PACKAGE := $(shell python setup.py --name)

PROJECT_DIR ?= $(shell pwd)
MODEL_DIR := $(PROJECT_DIR)/$(PACKAGE)/model
SIM_DIR := $(MODEL_DIR)/sim

PIP := $(VENV)/bin/pip
PYTHON := $(VENV)/bin/python
BPFPM ?= bpfpm

PYPI ?= 'https://artifactory.ciena.com/api/pypi/blueplanet-pypi/simple'

GIT_REPO_NAME ?= $(shell basename `git remote show -n origin | grep Fetch | cut -d. -f3`)

all: help

include bp2.mk

clean:
	rm -rf *.deb
	rm -rf build
	rm -rf dist
	rm -rf *.egg
	rm -rf *.pyc
	rm -rf env

basic-help:
	@echo "  help         this list"
	@echo "  clean        delete temporary files"

env-help:
	@echo " --------------------------------------------------------"
	@echo "/ virtualenv backed commands                            /"
	@echo "--------------------------------------------------------"
	@echo "  prepare-venv install requirements and self into virtualenv ./env"
	@echo "  fresh-venv   prepare a virtualenv without locked requirements"
	@echo "  test         run unit tests, model tests, and sim tests"
	@echo "  utest        run unit tests"
	@echo "  test-flake8  run flake8 tests"
	@echo "  test-sim     run simulator tests"
	@echo "  coverage     run unit tests with code coverage reporting"
	@echo "  requirements generate new requirements.txt"
	@echo "  release      release version with bpfrelease"

help: basic-help env-help bp2-help

# virtualenv related commands
#
prepare-venv:
# Workaround for pyang uninstall
	$(HIDE)rm -rf $(VENV)/lib/python2.7/site-packages/pyang*
	$(HIDE)virtualenv $(VENV)
	$(HIDE)$(PIP) install --upgrade -i $(PYPI) -r requirements.txt
	$(HIDE)$(PIP) install -i $(PYPI) -e .

fresh-venv:
	-$(HIDE)rm -rf $(VENV)
	$(HIDE)virtualenv $(VENV)
	$(HIDE)$(PIP) install -i $(PYPI) -e .
	$(HIDE)$(PIP) install -i $(PYPI) -r requirements-host.txt

requirements:
	$(HIDE)$(PIP) uninstall -y $(PACKAGE)
	$(HIDE)$(PIP) freeze > requirements.txt
	$(HIDE)$(PIP) install -e .

release:
	$(HIDE)$(VENV)/bin/bpfrelease --organization ra --repository $(GIT_REPO_NAME) --project .
	$(HIDE)$(VENV)/bin/gdfpm $(DOCKER_IMAGE) $(shell $(VENV)/bin/bpfrelease --project-version)

test: utest test-model-commands test-model-validate test-model-error test-sim test-flake8

utest:
	$(HIDE)$(VENV)/bin/nosetests -v

test-flake8:
	$(HIDE)$(VENV)/bin/flake8 $(PACKAGE)

test-model-validate:
	$(HIDE)$(VENV)/bin/bpprov-cli validate $(MODEL_DIR)

test-model-commands:
	$(HIDE)$(VENV)/bin/bpprov-cli test $(MODEL_DIR)

test-model-error:
	$(HIDE)$(VENV)/bin/bpprov-cli test-error $(MODEL_DIR)

test-sim:
	$(HIDE)$(VENV)/bin/bpprov-cli test-sim $(SIM_DIR)

coverage:
	$(HIDE)$(VENV)/bin/nosetests --with-coverage --cover-erase --cover-package $(PACKAGE)
