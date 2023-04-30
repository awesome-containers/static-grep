# https://github.com/awesome-containers/static-bash
ARG STATIC_BASH_VERSION=5.2.15
ARG STATIC_BASH_IMAGE=ghcr.io/awesome-containers/static-bash

# https://github.com/awesome-containers/alpine-build-essential
ARG BUILD_ESSENTIAL_VERSION=3.17
ARG BUILD_ESSENTIAL_IMAGE=ghcr.io/awesome-containers/alpine-build-essential


FROM $STATIC_BASH_IMAGE:$STATIC_BASH_VERSION AS static-bash
FROM $BUILD_ESSENTIAL_IMAGE:$BUILD_ESSENTIAL_VERSION AS build

# hadolint ignore=DL3018
RUN apk add --no-cache pcre2-dev

# https://git.savannah.gnu.org/cgit/grep.git
ARG GREP_VERSION=3.10

WORKDIR /src/grep
RUN set -xeu; \
    curl -#Lo grep.tar.gz \
        "https://ftp.gnu.org/gnu/grep/grep-$GREP_VERSION.tar.xz"; \
    tar -xvf grep.tar.gz --strip-components=1; \
    rm -f grep.tar.gz

ARG CFLAGS='-w -g -Os -static'
RUN set -xeu; \
    ./configure; \
    make -j"$(nproc)"; \
    mkdir bin; \
    cp src/grep src/fgrep src/egrep bin/; \
    strip -s -R .comment --strip-unneeded bin/grep; \
    chmod -cR 755 bin/*; \
    chown -cR 0:0 bin/*; \
    ! ldd bin/grep && :; \
    ./bin/grep -V

# static grep image
FROM static-bash
COPY --from=build /src/grep/bin/ /bin/
