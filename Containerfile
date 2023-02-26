# https://github.com/awesome-containers/static-bash
ARG STATIC_BASH_VERSION=5.2.15

FROM ghcr.io/awesome-containers/alpine-build-essential:3.17 AS build

# https://git.savannah.gnu.org/cgit/grep.git
ARG GREP_VERSION=3.8

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
    chmod -cR 755 src/grep src/fgrep bin/*; \
    chown -cR 0:0 src/grep src/fgrep bin/*; \
    ! ldd bin/grep && :; \
    ./bin/grep -V

# static grep image
FROM ghcr.io/awesome-containers/static-bash:$STATIC_BASH_VERSION
COPY --from=build /src/grep/bin/ /bin/
