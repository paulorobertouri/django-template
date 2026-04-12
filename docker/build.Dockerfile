FROM python:3.13-slim
COPY --from=ghcr.io/astral-sh/uv:latest /uv /bin/uv
WORKDIR /app
COPY pyproject.toml ./
RUN uv sync --no-dev
COPY config/ ./config/
COPY app/ ./app/
COPY main.py ./
COPY manage.py ./
ENV PATH="/app/.venv/bin:$PATH"
CMD ["uvicorn", "config.asgi:application", "--host", "0.0.0.0", "--port", "8000"]
