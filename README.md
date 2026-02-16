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
Files are copied to `${ENTRYPOINT_HOME}/.ssh` before `autossh` starts.

```sh
docker run --rm \
	-e PUID=$(id -u) \
	-e PGID=$(id -g) \
	-v /path/to/ssh-files:/install:ro \
	ghcr.io/coolcow/autossh \
	-M 0 -N user@example.org
```

### Runtime Environment Variables

| Variable | Default | Description |
| --- | --- | --- |
| `PUID` | `1000` | User ID to run the process as. |
| `PGID` | `1000` | Group ID to run the process as. |
| `ENTRYPOINT_USER` | `autossh` | Internal user used by entrypoint scripts. |
| `ENTRYPOINT_GROUP` | `autossh` | Internal group used by entrypoint scripts. |
| `ENTRYPOINT_HOME` | `/home` | Working directory and SSH home path inside the container. |

---

## Configuration

### Build-Time Arguments

Customize the image at build time with `docker build --build-arg <KEY>=<VALUE>`.

| Argument | Default | Description |
| --- | --- | --- |
| `ALPINE_VERSION` | `3.23.3` | Version of the Alpine base image. |
| `ENTRYPOINTS_VERSION` | `2.0.0` | Version of the `coolcow/entrypoints` image used for scripts. |

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
