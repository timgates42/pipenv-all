#!/bin/bash

set -euxo pipefail

BASEDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

cd "${BASEDIR}"
echo "${PYTHONVERS}"

# Before we go to town with deadsnake get distro pythons in good order
apt-get update
apt-get install -qq -y build-essential
apt-get install -qq -y \
  python python-pip python-dev \
  python3 python3-pip python3-dev
python2.7 -m pip install --upgrade pip
python2.7 -m pip install pipenv
python3.6 -m pip install --upgrade pip
python3.6 -m pip install pipenv

NODISTRO_PYTHONVERS=$( echo "${PYTHONVERS}" | sed 's/python2[.]7/ /;s/python3[.]6//' )
# Now try deadsnakes
apt-get install -qq -y openssl
apt-get install -qq -y software-properties-common
add-apt-repository ppa:deadsnakes
add-apt-repository ppa:pypy/ppa
apt-get update
apt-get install -qq -y ${NODISTRO_PYTHONVERS}

apt-get install -qq -y curl
apt-get install -qq -y libffi-dev

for PYVER in ${NODISTRO_PYTHONVERS} ; do
  apt-get install -qq -y ${PYVER}-dev
  if [[ "${PYVER}" =~ python[0-9][.][0-9] ]] ; then
    SHORTPY="$(echo "${PYVER}" | sed s/python//)"
    if ! curl --fail "https://bootstrap.pypa.io/${SHORTPY}/get-pip.py" -o get-pip.py ; then
      curl --fail https://bootstrap.pypa.io/get-pip.py -o get-pip.py
    fi
  else
    curl --fail https://bootstrap.pypa.io/get-pip.py -o get-pip.py
  fi
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
