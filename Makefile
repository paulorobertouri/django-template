SHELL := /bin/bash

.PHONY: install install-dev run test docker-build docker-test docker-curl-test

install:
	./scripts/ubuntu/install.sh

install-dev:
	./scripts/ubuntu/install-dev.sh

run:
	./scripts/ubuntu/run.sh

test:
	./scripts/ubuntu/test.sh

docker-build:
	docker build -f docker/build.Dockerfile -t django-template-build .

docker-test:
	docker build -f docker/test.Dockerfile -t django-template-test .
	docker run --rm django-template-test

docker-curl-test:
	./scripts/ubuntu/docker-curl-test.sh
