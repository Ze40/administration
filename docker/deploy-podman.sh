#!/bin/sh
set -eu

: "${APP_IMAGE:?APP_IMAGE is required}"
: "${APP_PORT:?APP_PORT is required}"

POSTGRES_DB="${POSTGRES_DB:-kubsu}"
POSTGRES_USER="${POSTGRES_USER:-kubsu}"
POSTGRES_PASSWORD="${POSTGRES_PASSWORD:-kubsu}"

podman pull "$APP_IMAGE"
podman pod exists administration || podman pod create --name administration -p "${APP_PORT}:${APP_PORT}"

if ! podman container exists administration-postgres; then
    podman volume exists administration-postgres-data >/dev/null 2>&1 || podman volume create administration-postgres-data
    podman run -d \
        --name administration-postgres \
        --pod administration \
        -e POSTGRES_DB="$POSTGRES_DB" \
        -e POSTGRES_USER="$POSTGRES_USER" \
        -e POSTGRES_PASSWORD="$POSTGRES_PASSWORD" \
        -v administration-postgres-data:/var/lib/postgresql/data \
        docker.io/library/postgres:16-alpine
fi

podman rm -f administration-app >/dev/null 2>&1 || true
podman run -d \
    --name administration-app \
    --pod administration \
    -e PORT="$APP_PORT" \
    -e DATABASE_URL="postgresql+psycopg://${POSTGRES_USER}:${POSTGRES_PASSWORD}@127.0.0.1:5432/${POSTGRES_DB}" \
    "$APP_IMAGE"
