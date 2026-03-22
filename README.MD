# django-template

Modern Django template with service/repository layering, JWT auth, and test coverage.

## Stack

- Django + Django Ninja
- PyJWT + python-dotenv
- Ruff + mypy
- Pytest + pytest-django + coverage
- uv (package manager)

## Endpoints

- `GET /health`
- `GET /docs`
- `GET /v1/public`
- `GET /v1/customer`
- `GET /v1/auth/login`
- `GET /v1/private`

## JWT Contract

Login returns:
- Body: `{"token":"..."}`
- Header: `Authorization: Bearer <token>`
- Header: `X-JWT-Token: <token>`

## Commands

- `make install` — install production dependencies
- `make install-dev` — install dev dependencies
- `make run` — run the application
- `make test` — run tests with coverage
- `make docker-build` — build Docker image
- `make docker-test` — run tests in Docker
- `make docker-curl-test` — run curl integration tests in Docker

## Environment Variables

- `PORT=8000`
- `JWT_SECRET=your-super-secret-jwt-key-at-least-32-characters-long-for-hs256`
- `JWT_ALGORITHM=HS256`
- `JWT_EXPIRY_MINUTES=60`

## Project Structure

```text
.
├── main.py
├── app/
│   ├── api/            # route handlers
│   ├── domain/         # domain models
│   ├── repositories/   # data-access abstractions
│   └── services/       # business logic
├── tests/
│   ├── unit/
│   ├── e2e/
│   └── docker/
└── docker/
    ├── build.Dockerfile
    └── test.Dockerfile
```

## Architecture

```text
HTTP -> API Routes -> JWT Middleware -> Services -> Repositories -> Domain
```

## Quality Gates

- Lint must pass.
- Typecheck must pass.
- Test suite must pass.
- Coverage report generated on test runs.
