#!/bin/sh

set -e

install_ssh_assets() {
  if [ ! -d /install ]; then
    return 0
  fi

  if [ -z "$(find /install -mindepth 1 -print -quit 2>/dev/null)" ]; then
    return 0
  fi

  mkdir -p "${ENTRYPOINT_HOME}/.ssh"
  cp -a /install/. "${ENTRYPOINT_HOME}/.ssh/"

  chmod 700 "${ENTRYPOINT_HOME}/.ssh"
  chmod 600 "${ENTRYPOINT_HOME}/.ssh"/* 2>/dev/null || true
  chmod 644 "${ENTRYPOINT_HOME}/.ssh"/*.pub 2>/dev/null || true
  chown -R "${PUID:-1000}:${PGID:-1000}" "${ENTRYPOINT_HOME}/.ssh"
}

install_ssh_assets

exec /usr/local/bin/entrypoint_su-exec.sh autossh "$@"