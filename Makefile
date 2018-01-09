PYPY_VERSION=5.10.0
ALPINE_VERSION=3.6
BASE_REPO=njoyce/pypy

ifeq ($(strip $(shell git status --porcelain 2>/dev/null)),)
	GIT_TREE_STATE=clean
else
	GIT_TREE_STATE=dirty
endif

clean:
	rm Dockerfile || true

Dockerfile: Dockerfile.template
	sed \
		-e 's!{{ .PyPyVersion }}!'"$(PYPY_VERSION)"'!g' \
		-e 's!{{ .AlpineVersion }}!'"$(ALPINE_VERSION)"'!g' \
		Dockerfile.template > Dockerfile

build: Dockerfile
	docker build .

tag: Dockerfile
ifeq ($(GIT_TREE_STATE),dirty)
    $(error git state is not clean)
endif
	docker build -t $(BASE_REPO):2-$(PYPY_VERSION) .

push: tag
	docker push $(BASE_REPO):2-$(PYPY_VERSION)
