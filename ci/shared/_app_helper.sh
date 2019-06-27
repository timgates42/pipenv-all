#!/bin/bash

set -euxo pipefail

DOCKER_IMAGE_NAME="pipenv-all"
DOCKER_REPOSITORY="3amigos"
VERSION_MAJOR=$(($(date -u +'%Y') - 2000))
VERSION_MINOR=$(date -u +'%m')
VERSION_PATCH=$(date -u +'%d%H%M%S')
VERSION="${VERSION_MAJOR}.${VERSION_MINOR}.${VERSION_PATCH}"
PYTHONVERS="\
    python2.6 \
    python2.7 \
    python3.2 \
    python3.3 \
    python3.4 \
    python3.5 \
    python3.6 \
    python3.7 \
    pypy \
"
export PYTHONVERS
