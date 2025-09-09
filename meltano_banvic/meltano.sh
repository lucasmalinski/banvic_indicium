#!/usr/bin/env bash
docker run \
    -u $(id -u):$(id -g) \
    -e HOME=/projects \
    -v "$(pwd)":/projects \
    -w /projects \
    meltano/meltano:latest-python3.12 "$@"
