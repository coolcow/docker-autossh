# Global build arguments
ARG ENTRYPOINTS_VERSION=2.2.0
ARG ALPINE_VERSION=3.23.3

# Stage to fetch scripts from the versioned entrypoints asset image
FROM ghcr.io/coolcow/entrypoints:${ENTRYPOINTS_VERSION} AS entrypoints

# Main build stage
FROM alpine:${ALPINE_VERSION}

# Runtime environment variables
ENV AUTOSSH_UID=1000 \
      AUTOSSH_GID=1000 \
      AUTOSSH_REMAP_IDS=1 \
      AUTOSSH_USER=autossh \
      AUTOSSH_GROUP=autossh \
      AUTOSSH_HOME=/home/autossh \
      AUTOSSH_SHELL=/bin/sh

# install autossh and required dependencies
RUN apk --no-cache --update add \
      autossh \
      openssh-client \
      shadow \
      su-exec

# Copy required scripts from the entrypoints asset image
COPY --from=entrypoints /assets/ensure_user_group_home.sh /usr/local/bin/
COPY --from=entrypoints /assets/entrypoint_su-exec.sh /usr/local/bin/

# Copy image-specific entrypoint
COPY entrypoint.sh /usr/local/bin/

# Make scripts executable
RUN chmod +x /usr/local/bin/*.sh

WORKDIR $AUTOSSH_HOME

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["--help"]

ARG LABEL_VERSION="latest"
ARG LABEL_BUILD_DATE
ARG LABEL_VCS_REF
ARG LABEL_LICENSE="MIT"
ARG LABEL_IMAGE_NAME="ghcr.io/coolcow/autossh"
ARG LABEL_DESCRIPTION="Minimal Alpine-based autossh Docker image."
ARG LABEL_URL="https://ghcr.io/coolcow/autossh"
ARG LABEL_VCS_URL="https://github.com/coolcow/docker-autossh"
ARG LABEL_MAINTAINER="Jean-Michel Ruiz (coolcow) <mail@coolcow.org>"

# OCI / OpenContainer image labels
LABEL org.opencontainers.image.title=$LABEL_IMAGE_NAME \
      org.opencontainers.image.description=$LABEL_DESCRIPTION \
      org.opencontainers.image.version=$LABEL_VERSION \
      org.opencontainers.image.created=$LABEL_BUILD_DATE \
      org.opencontainers.image.revision=$LABEL_VCS_REF \
      org.opencontainers.image.authors=$LABEL_MAINTAINER \
      org.opencontainers.image.licenses=$LABEL_LICENSE \
      org.opencontainers.image.source=$LABEL_VCS_URL \
      org.opencontainers.image.url=$LABEL_URL

VOLUME $AUTOSSH_HOME