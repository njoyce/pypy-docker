PYPY_VERSION=5.8.0

ALPINE_VERSION=3.6
BASE_IMAGE=quay.io/njoyce/base:alpine-$(ALPINE_VERSION)
DOCKER_IMAGE=quay.io/njoyce/pypy
DOCKER_TAG=py2-$(PYPY_VERSION)

build:
	rocker build \
		--pull \
		--attach \
		--var PyPyVersion=${PYPY_VERSION} \
		--var AlpineVersion=${ALPINE_VERSION} \
		--var BaseImage=${BASE_IMAGE} \
		--var DockerImage=${DOCKER_IMAGE} \
		--var DockerTag=${DOCKER_TAG}

push: build
	docker push $(DOCKER_IMAGE):$(DOCKER_TAG)

run: build
	docker run -it ${DOCKER_IMAGE}:${DOCKER_TAG} /bin/ash
