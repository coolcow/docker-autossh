#!/bin/sh

set -e

export TARGET_UID="${AUTOSSH_UID:-1000}"
export TARGET_GID="${AUTOSSH_GID:-1000}"
export TARGET_REMAP_IDS="${AUTOSSH_REMAP_IDS:-1}"
export TARGET_USER="${AUTOSSH_USER:-autossh}"
export TARGET_GROUP="${AUTOSSH_GROUP:-autossh}"
export TARGET_HOME="${AUTOSSH_HOME:-/home/autossh}"
export TARGET_SHELL="${AUTOSSH_SHELL:-/bin/sh}"

install_ssh_assets() {
  if [ ! -d /install ]; then
    return 0
  fi

  if [ -z "$(find /install -mindepth 1 -print -quit 2>/dev/null)" ]; then
    return 0
  fi

  mkdir -p "${TARGET_HOME}/.ssh"
  cp -a /install/. "${TARGET_HOME}/.ssh/"

  chmod 700 "${TARGET_HOME}/.ssh"
  chmod 600 "${TARGET_HOME}/.ssh"/* 2>/dev/null || true
  chmod 644 "${TARGET_HOME}/.ssh"/*.pub 2>/dev/null || true
  chown -R "${TARGET_UID}:${TARGET_GID}" "${TARGET_HOME}/.ssh"
}

install_ssh_assets

exec /usr/local/bin/entrypoint_su-exec.sh autossh "$@"