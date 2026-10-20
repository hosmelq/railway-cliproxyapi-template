#!/bin/sh
set -eu
umask 077

: "${MANAGEMENT_PASSWORD:?Set MANAGEMENT_PASSWORD to a unique administrator key}"
[ "${#MANAGEMENT_PASSWORD}" -ge 32 ] || {
  echo 'MANAGEMENT_PASSWORD must contain at least 32 characters' >&2
  exit 1
}
mkdir -p /data/auths

if [ ! -f /data/config.yaml ]; then
  : "${CLIPROXY_API_KEY:?Set CLIPROXY_API_KEY before the first start}"
  [ "${#CLIPROXY_API_KEY}" -ge 32 ] || {
    echo 'CLIPROXY_API_KEY must contain at least 32 characters' >&2
    exit 1
  }
  case "$CLIPROXY_API_KEY" in *[!a-zA-Z0-9_-]*)
    echo 'CLIPROXY_API_KEY must use letters, digits, underscores or hyphens' >&2
    exit 1
    ;;
  esac
  case "$PORT" in '' | *[!0-9]*)
    echo 'PORT must be a number between 1 and 65535' >&2
    exit 1
    ;;
  esac
  [ "$PORT" -ge 1 ] && [ "$PORT" -le 65535 ] || {
    echo 'PORT must be a number between 1 and 65535' >&2
    exit 1
  }
  sed -e "s/__CLIPROXY_API_KEY__/$CLIPROXY_API_KEY/" -e "s/__PORT__/$PORT/" \
    /opt/railway/config.initial.yaml >/data/config.yaml.new
  mv /data/config.yaml.new /data/config.yaml
fi

exec /CLIProxyAPI/CLIProxyAPI --config /data/config.yaml
