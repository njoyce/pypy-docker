PyPy - http://pypy.org/

In a Docker container. Using Alpine. Simples.

Pulling
-------

```sh
$ docker pull quay.io/gigafm/pypy:py2-5.4.1
```

Images is ``122.4 MB`` uncompressed. It is a _fat_ build - meaning all the
extensions such as ``tk``, ``openssl``, ``ncurses``.

Latest version (at time of building) of ``pip`` and ``setuptools``.

Building:
---------

Note that only Py2.7 support has been added so far.

```sh
make build
```

Variables for the build:
------------------------
+----------------+-------------+
| Name           | Description |
|----------------|-------------|
| BASE_IMAGE     | The name of the base image to use to build PyPy AND inject in to the final image |
| PYPY_VERSION   | The PyPy version to build. |
| DOCKER_IMAGE   | The image name to tag the build with |
| DOCKER_TAG     | The tag of the build |
| ALPINE_VERSION | The version of Alpine to use |
+----------------+------------+

Pushing:
--------

```sh
make push
```

Same variables are used as the build section.

Rocker
------

rocker - https://github.com/grammarly/rocker is used to create the container. It
provides some neat enhanced functionality like the ability to define a build
container, export the artifacts then import them in to a clean image (no build
dependencies). It is the evolution of the ``Dockerfile`` (and completely
backward compatible - you can run your Dockerfiles with rocker).

