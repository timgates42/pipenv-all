Introduction
============

pipenv-all is a docker image with as many python versions as possible
installed with pipenv. This allows for quickly testing a python library
against a wide variety of python versions without requiring the build agent to
have them all installed. Pipenv allows for the toolchain to be locked and
updated incrementally looking for breakages due to dependency updates, its
similar to pip freeze but maintains SHAs protecting against modifications to
the same version (which can be achieved in Pypi if a developer tries).
