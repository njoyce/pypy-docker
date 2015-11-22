DOCKER_IMAGE=quay.io/njoyce/pypy
DOCKER_TAG?=dev

build:
	docker build -t \
                $(DOCKER_IMAGE):$(DOCKER_TAG) \
                .

run: build
	docker run -it --rm \
                $(DOCKER_IMAGE):$(DOCKER_TAG)

debug: build
	docker run -it --rm \
                $(DOCKER_IMAGE):$(DOCKER_TAG) \
                /bin/sh

push: build
ifeq ($(DOCKER_TAG),dev)
	echo "Dev builds can't be pushed" || exit 1
else
	docker push $(DOCKER_IMAGE):$(DOCKER_TAG)
endif
