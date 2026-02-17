# ghcr.io/coolcow/autossh

A minimal Alpine-based Docker image for [autossh](https://www.harding.motd.ca/autossh/).

The image runs `autossh` as non-root via reusable scripts from `coolcow/entrypoints` and supports injecting SSH material through `/install`.

---

## Usage

### Quick Start

```sh
docker run --rm ghcr.io/coolcow/autossh --help
```

### Provide SSH Config/Keys

Mount a directory with SSH files (for example `config`, `id_rsa`, `known_hosts`) to `/install`.
Files are copied to `${AUTOSSH_HOME}/.ssh` before `autossh` starts.

```sh
docker run --rm \
	-e AUTOSSH_UID=$(id -u) \
	-e AUTOSSH_GID=$(id -g) \
	-v /path/to/autossh-home:/home/autossh \
	-v /path/to/ssh-files:/install:ro \
	ghcr.io/coolcow/autossh \
	-M 0 -N user@example.org
```

### Runtime Environment Variables

| Variable | Default | Target | Description |
| --- | --- | --- | --- |
| `AUTOSSH_UID` | `1000` | `TARGET_UID` | User ID to run the process as. |
| `AUTOSSH_GID` | `1000` | `TARGET_GID` | Group ID to run the process as. |
| `AUTOSSH_REMAP_IDS` | `1` | `TARGET_REMAP_IDS` | Set to `0` to disable remapping conflicting UID/GID entries. |
| `AUTOSSH_USER` | `autossh` | `TARGET_USER` | Runtime user name inside the container. |
| `AUTOSSH_GROUP` | `autossh` | `TARGET_GROUP` | Runtime group name inside the container. |
| `AUTOSSH_HOME` | `/home/autossh` | `TARGET_HOME` | Home directory used by `autossh` and as default workdir. |
| `AUTOSSH_SHELL` | `/bin/sh` | `TARGET_SHELL` | Login shell for the runtime user. |

`Target` shows the corresponding variable used by `coolcow/entrypoints`.

---

## Configuration

### Build-Time Arguments

Customize the image at build time with `docker build --build-arg <KEY>=<VALUE>`.

| Argument | Default | Description |
| --- | --- | --- |
| `ALPINE_VERSION` | `3.23.3` | Version of the Alpine base image. |
| `ENTRYPOINTS_VERSION` | `2.2.0` | Version of the `coolcow/entrypoints` image used for scripts. |

---

## Migration Notes

Runtime user/group environment variables were renamed to image-specific `AUTOSSH_*` names.

- `PUID` → `AUTOSSH_UID`
- `PGID` → `AUTOSSH_GID`
- `ENTRYPOINT_USER` → `AUTOSSH_USER`
- `ENTRYPOINT_GROUP` → `AUTOSSH_GROUP`
- `ENTRYPOINT_HOME` → `AUTOSSH_HOME`

Update your `docker run` / `docker-compose` environment configuration accordingly when upgrading from older tags.

---

## Local Testing

Run the built-in smoke tests locally.

1. `docker build -t ghcr.io/coolcow/autossh:local-test-build -f build/Dockerfile build`
2. `docker build --build-arg APP_IMAGE=ghcr.io/coolcow/autossh:local-test-build -f build/Dockerfile.test build`

---

## References

- [autossh Homepage](https://www.harding.motd.ca/autossh/)
- [docker-entrypoints](https://github.com/coolcow/docker-entrypoints)

---

## License

MIT. See [LICENSE.txt](LICENSE.txt) for details.
