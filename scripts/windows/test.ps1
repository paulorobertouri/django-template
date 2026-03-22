$ErrorActionPreference = "Stop"
uv sync
uv run pytest --cov --cov-report=term --cov-report=term-missing
