FROM ubuntu:14.04

# http://bugs.python.org/issue19846
# > At the moment, setting "LANG=C" on a Linux system *fundamentally breaks Python 3*, and that's not OK.
ENV LANG C.UTF-8

RUN apt-get update && apt-get install -y --no-install-recommends \
        ca-certificates \
        libexpat1 \
        libsqlite3-0 \
    && rm -rf /var/lib/apt/lists/*

ENV PYPY_VERSION 2.6.1
# if this is called "PIP_VERSION", pip explodes with "ValueError: invalid truth value '<VERSION>'"
ENV PYTHON_PIP_VERSION 7.1.2

RUN set -x \
    && apt-get update && apt-get install -y bzip2 curl --no-install-recommends \
    && curl -SL "https://bitbucket.org/pypy/pypy/downloads/pypy-${PYPY_VERSION}-linux64.tar.bz2" \
    | tar -xjC /usr/local --strip-components=1 \
    && curl -SL 'https://bootstrap.pypa.io/get-pip.py' | /usr/local/bin/pypy \
    && apt-get purge -y --auto-remove bzip2 curl \
    && pip install --upgrade pip==$PYTHON_PIP_VERSION setuptools \
    && rm -rf /root/.pip \
    && rm -rf /var/lib/apt/lists/*
