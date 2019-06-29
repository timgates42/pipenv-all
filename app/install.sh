#!/bin/bash

set -euxo pipefail

BASEDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

cd "${BASEDIR}"
echo "${PYTHONVERS}"

# Before we go to town with deadsnake get distro pythons in good order
apt-get update
DEBIAN_FRONTEND=noninteractive apt-get install -qq -y --no-install-recommends apt-utils
DEBIAN_FRONTEND=noninteractive apt-get install -qq -y --no-install-recommends build-essential
DEBIAN_FRONTEND=noninteractive apt-get install -qq -y --no-install-recommends \
  python python-pip python-dev \
  python3 python3-pip python3-dev
python2.7 -m pip install --upgrade pip
python2.7 -m pip install pipenv
python3.6 -m pip install --upgrade pip
python3.6 -m pip install pipenv

NODISTRO_PYTHONVERS=$( echo "${PYTHONVERS}" | sed 's/2[.]7/ /;s/3[.]6/ /' )
# Now try deadsnakes
DEBIAN_FRONTEND=noninteractive apt-get install -qq -y --no-install-recommends openssl
DEBIAN_FRONTEND=noninteractive apt-get install -qq -y --no-install-recommends software-properties-common
add-apt-repository ppa:deadsnakes
add-apt-repository ppa:pypy/ppa
apt-get update
DEBIAN_FRONTEND=noninteractive apt-get install -qq -y --no-install-recommends curl
DEBIAN_FRONTEND=noninteractive apt-get install -qq -y --no-install-recommends libffi-dev
for PYVER in ${NODISTRO_PYTHONVERS} ; do
  DEBIAN_FRONTEND=noninteractive apt-get install -qq -y \
      --no-install-recommends python${PYVER} python${PYVER}-dev
  if ! curl --fail "https://bootstrap.pypa.io/${PYVER}/get-pip.py" -o get-pip.py ; then
    curl --fail https://bootstrap.pypa.io/get-pip.py -o get-pip.py
  fi
  "python${PYVER}" get-pip.py
  "pip${PYVER}" install pipenv
done
