FROM gliderlabs/alpine:3.2

ENV PYPY_VERSION 4.0.0

# add dev packages
RUN apk-install build-base bzip2-dev ca-certificates expat-dev gdbm-dev libc-dev libffi-dev linux-headers ncurses-dev openssl-dev python sqlite-dev tar wget zlib-dev \
    && mkdir -p /tmp/src \
    && cd /tmp/src \
    && wget "https://bitbucket.org/pypy/pypy/downloads/pypy-${PYPY_VERSION}-src.tar.bz2" \
    && tar -xvjf "pypy-${PYPY_VERSION}-src.tar.bz2" \
    && cd "pypy-${PYPY_VERSION}-src" \
    && python rpython/bin/rpython --opt=jit pypy/goal/targetpypystandalone.py \
    && python pypy/tool/release/package.py --without-tk --override_pypy_c ./pypy-c --archive-name "pypy-${PYPY_VERSION}-linux64" \
    && cd "/tmp/usession-release-${PYPY_VERSION}-1/build/pypy-${PYPY_VERSION}-linux64" \
    && cp -Rp * /usr \
# remove the dev packages
    && apk del build-base bzip2-dev ca-certificates expat-dev gdbm-dev libc-dev libffi-dev linux-headers ncurses-dev openssl-dev python sqlite-dev tar wget zlib-dev \
# add back the runtime dependencies
    && apk-install expat gdbm libc6-compat libbz2 libcrypto1.0 libffi libssl1.0 ncurses sqlite zlib  \
    && rm -rf /tmp/*

# if this is called "PIP_VERSION", pip explodes with "ValueError: invalid truth value '<VERSION>'"
ENV PYTHON_PIP_VERSION 7.1.2

RUN apk-install curl tar ca-certificates \
    && curl -SL 'https://bootstrap.pypa.io/get-pip.py' | /usr/bin/pypy \
    && pip install --upgrade pip==$PYTHON_PIP_VERSION setuptools \
    && rm -rf /root/.pip \
    && apk del curl tar ca-certificates
