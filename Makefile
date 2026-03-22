SHELL := /bin/bash

install:
uv sync --no-dev

install-dev:
uv sync

run:
uv run python main.py

test:
uv run pytest --cov --cov-report=term --cov-report=term-missing

docker-build:
docker build -f docker/build.Dockerfile -t django-template-build .

docker-test:
docker build -f docker/test.Dockerfile -t django-template-test .
docker run --rm django-template-test

docker-curl-test:
bash tests/docker/test_with_curl.sh
