PYPY_VERSION=5.4.1

ALPINE_VERSION=3.4
BASE_IMAGE=quay.io/gigafm/base:alpine-$(ALPINE_VERSION)
DOCKER_IMAGE=quay.io/gigafm/pypy
DOCKER_TAG=py2-$(PYPY_VERSION)

build:
	rocker build \
		--pull \
		--var PyPyVersion=${PYPY_VERSION} \
		--var AlpineVersion=${ALPINE_VERSION} \
		--var BaseImage=${BASE_IMAGE} \
		--var DockerImage=${DOCKER_IMAGE} \
		--var DockerTag=${DOCKER_TAG}

push: build
	docker push $(DOCKER_IMAGE):$(DOCKER_TAG)
