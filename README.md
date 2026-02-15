# ghcr.io/coolcow/autossh

Simple and minimal Alpine-based Docker image for [autossh](https://www.harding.motd.ca/autossh/).

---

## Overview

autossh starts and monitors an `ssh` process, automatically restarting it if the connection drops.

---

## Usage

### Quick Start

```sh
docker run --rm ghcr.io/coolcow/autossh
```

Default runtime behavior:

- **ENTRYPOINT:** `/entrypoint.sh`
- **CMD:** `--help`

### Provide SSH Config/Keys

The entrypoint installs files from `/install/*` into `/root/.ssh/*` before starting `autossh`.

```sh
docker run --rm \
	-v <PATH_TO_SSH_FILES>:/install:ro \
	ghcr.io/coolcow/autossh \
		<AUTOSSH_ARGS>
```

Replace `<PATH_TO_SSH_FILES>` with a directory containing SSH files (for example `config`, `id_rsa`, `known_hosts`).

---

## References

- [autossh Homepage](https://www.harding.motd.ca/autossh/)
