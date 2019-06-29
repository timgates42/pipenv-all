#!/bin/bash

set -euxo pipefail

THISDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
BASEDIR="$( dirname "${THISDIR}" )"

for PYVER in ${PYTHONVERS} ; do
    rm -rf "${BASEDIR}/templates/${PYVER}"
    mkdir -p "${BASEDIR}/templates/${PYVER}"
    cd "${BASEDIR}/templates/${PYVER}"
    "python${PYVER}" -m pipenv --python "${PYVER}"
done
echo 'Testing Complete'
