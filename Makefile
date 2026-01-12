SHELL := /bin/bash

.PHONY: default
default:
	cd srcs && bash ./run_docker.sh

.PHONY: blank-start
blank-start:
	cd srcs && bash ./run_docker.sh --blank-start

.PHONY: clean
blank-start:
	cd srcs && bash ./run_docker.sh --clean


