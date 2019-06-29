#!/bin/bash

set -euxo pipefail

THISDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
BASEDIR="$( dirname "${THISDIR}" )"

source "${BASEDIR}/ci/shared/_app_helper.sh"
source "${BASEDIR}/ci/shared/_docker_helper.sh"

docker_compose_run app "/workspace/ci/_test.sh"

docker login
docker tag "${DOCKER_IMAGE_NAME}" "${DOCKER_REPOSITORY}/${DOCKER_IMAGE_NAME}:${VERSION}"
docker tag "${DOCKER_IMAGE_NAME}" "${DOCKER_REPOSITORY}/${DOCKER_IMAGE_NAME}:latest"
docker push "${DOCKER_REPOSITORY}/${DOCKER_IMAGE_NAME}:${VERSION}"
docker push "${DOCKER_REPOSITORY}/${DOCKER_IMAGE_NAME}:latest"
docker rmi "${DOCKER_REPOSITORY}/${DOCKER_IMAGE_NAME}:${VERSION}"
docker rmi "${DOCKER_REPOSITORY}/${DOCKER_IMAGE_NAME}:latest"
