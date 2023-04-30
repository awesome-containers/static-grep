# Statically linked Grep

Statically linked [Grep] container image with [Bash]

> 1,9M (1,1M bash)

```bash
ghcr.io/awesome-containers/static-grep:latest
ghcr.io/awesome-containers/static-grep:3.10

docker.io/awesomecontainers/static-grep:latest
docker.io/awesomecontainers/static-grep:3.10
```

Slim statically linked [Grep] container image with [Bash] stripped and
packaged with [UPX]

> 888K (578K bash)

```bash
ghcr.io/awesome-containers/static-grep:latest-slim
ghcr.io/awesome-containers/static-grep:3.10-slim

docker.io/awesomecontainers/static-grep:latest-slim
docker.io/awesomecontainers/static-grep:3.10-slim
```

[Grep]: https://www.gnu.org/software/grep/
[Bash]: https://github.com/awesome-containers/static-bash
[UPX]: https://upx.github.io/

<!--
```bash
image="localhost/${PWD##*/}"

podman build -t "$image:latest" .
podman build -t "$image:latest-slim" -f Containerfile-slim \
  --build-arg STATIC_GREP_IMAGE="$image" \
  --build-arg STATIC_GREP_VERSION=latest --no-cache .

echo "$image:latest"
podman inspect "$image:latest" | jq '.[].Size' | numfmt --to=iec
echo "$image:latest-slim"
podman inspect "$image:latest-slim" | jq '.[].Size' | numfmt --to=iec

```
-->
