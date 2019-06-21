#!/bin/bash

set -euxo pipefail

BASEDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

cd "${BASEDIR}"

PYTHONVERS=( 
    python2.7 \
    python3.2 \
    python3.3 \
    python3.4 \
    python3.5 \
    python3.6 \
    python3.7 \
    pypy \
)

apt-get update
apt-get install -qq -y openssl
apt-get install -qq -y software-properties-common
add-apt-repository ppa:deadsnakes
add-apt-repository ppa:pypy/ppa
apt-get update
apt-get install -qq -y "${PYTHONVERS[@]}"
apt-get install -qq -y python-pip python3-pip

apt-get install -qq -y curl
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py

for PYVER in "${PYTHONVERS[@]}" ; do
  if [ "${PYVER}" != "python2.7" -a "${PYVER}" != "python3.6" ] ; then
      "${PYVER}" get-pip.py
  fi
  "${PYVER}" -m pip install pipenv
done
