#!/bin/bash

set -euxo pipefail

THISDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
BASEDIR="$( dirname "${THISDIR}" )"

for PYVER in ${PYTHONVERS} ; do
    mkdir "${BASEDIR}/${PYVER}"
    cd "${BASEDIR}/${PYVER}"
    "python${PYVER}" -m pipenv --python "${PYVER}"
done
echo 'Testing Complete'
