# Django Template

Modern Django template with service/repository layering, JWT auth, and test coverage.

## Stack

- Django + Django Ninja
- PyJWT + python-dotenv
- Ruff + mypy
- Pytest + pytest-django + coverage

## Commands

- `./.venv/bin/python -m pytest --cov --cov-report=term --cov-report=term-missing`
- `./.venv/bin/python -m ruff check .`
- `./.venv/bin/python -m mypy .`

## Architecture

- `app/services`: business services
- `app/repositories`: data-access abstractions
- `app/domain`: domain models
- `tests`: unit and e2e suites

## Shared Template Contract

All Python templates in this repository follow the same quality contract.

### Functional Contract

- Keep business logic in service/domain modules.
- Keep transport/web concerns at API route layer.
- Keep tests split into fast unit tests and integration/e2e tests where applicable.

### Quality Gates

- Lint must pass.
- Typecheck must pass.
- Test suite must pass.
- Coverage report must be generated on test runs.

### Architecture Contract

- Domain and service logic isolated from framework wiring.
- Repository or adapter boundaries for persistence/integration concerns.
- Testable composition with deterministic defaults.
