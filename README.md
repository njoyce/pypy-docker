PyPy - http://pypy.org/

In a Docker container. Using Alpine. Simples.

Pulling
-------

```sh
docker pull njoyce/pypy:2-5.9.0
```

Images is ``124 MB`` uncompressed. It is a _fat_ build - meaning all the
extensions such as ``tk``, ``openssl``, ``ncurses`` are included.

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
| PYPY_VERSION   | The PyPy version to build. |
| ALPINE_VERSION | The version of Alpine to use |
+----------------+------------+

Pushing:
--------

```sh
make push
```

Same variables are used as the build section.
