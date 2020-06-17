#!/bin/bash

set -euxo pipefail

THISDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
BASEDIR="$( dirname "${THISDIR}" )"

source "${BASEDIR}/ci/shared/_app_helper.sh"
source "${BASEDIR}/ci/shared/_docker_helper.sh"

docker-compose build --no-cache
docker_compose_run app "/workspace/ci/_test.sh" "${VERSION}" "$@"
