FROM python:3.13-slim
COPY --from=ghcr.io/astral-sh/uv:latest /uv /bin/uv
WORKDIR /app
COPY pyproject.toml ./
RUN uv sync
COPY django_template/ ./django_template/
COPY app/ ./app/
COPY tests/ ./tests/
COPY main.py ./
COPY manage.py ./
ENV PATH="/app/.venv/bin:$PATH"
CMD ["pytest", "-q"]
