#!/bin/bash

set -euxo pipefail

BASEDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

cd "${BASEDIR}"
echo "${PYTHONVERS}"
apt-get update
apt-get install -qq -y openssl
apt-get install -qq -y software-properties-common
add-apt-repository ppa:deadsnakes
add-apt-repository ppa:pypy/ppa
apt-get update
apt-get install -qq -y ${PYTHONVERS}

apt-get install -qq -y curl
apt-get install -qq -y libffi-dev


for PYVER in ${PYTHONVERS} ; do
  apt-get install -qq -y ${PYVER}-dev
  if [[ "${PYVER}" =~ python[0-9][.][0-9] ]] ; then
    SHORTPY="$(echo "${PYVER}" | sed s/python//)"
    if ! curl --fail "https://bootstrap.pypa.io/${SHORTPY}/get-pip.py" -o get-pip.py ; then
      curl --fail https://bootstrap.pypa.io/get-pip.py -o get-pip.py
    fi
  else
    curl --fail https://bootstrap.pypa.io/get-pip.py -o get-pip.py
  fi
  SHORTPY=
  "${PYVER}" get-pip.py
  case "${PYVER}" in
  python2.6)
    pip2.6 install pipenv
    ;;
  *)
    "${PYVER}" -m pip install pipenv
    ;;
  esac
done
