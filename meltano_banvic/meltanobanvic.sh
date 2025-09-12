#!/bin/sh
set -e

# Facilita acesso a comandos meltano no container 
docker compose run --rm meltano "$@"