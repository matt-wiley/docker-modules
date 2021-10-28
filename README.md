# docker-modules

Modular installation components for use in Ubuntu/Debian-based Docker images.

### Usage

#### Quickstart

```Dockerfile
FROM ubuntu:20.04

USER root

RUN    apt-get update \
    && apt-get install -yq --no-install-recommends \
        ca-certificates \
        curl

WORKDIR /tmp

RUN    curl -sSL "https://raw.githubusercontent.com/matt-wiley/docker-modules/main/bin/installer.sh" -o installer.sh \
    && chmod +x ./installer.sh \
    && ./installer.sh download-scripts \
\
        docker-cli \ # Module names get listed here
\
    && ./installer.sh install

RUN rm -rf /tmp
```

The snippet above is a fully working Dockerfile. It can be copied and pasted as is. If it is run with the following Docker build command ...

```sh
docker build --no-cache -t modular-docker/modtest -f <your_dockerfile_name>
```

... and the resultant image is executed with this command ...

```sh
drh -v /var/run/docker.sock:/var/run/docker.sock modular-docker/modtest bash
```

... you will get a shell in a running Docker container which has the Docker CLI installed and the host Docker engine socket mount into it. 

In other words, Docker-in-Docker.

