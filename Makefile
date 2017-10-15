PYPY_VERSION=5.9.0
ALPINE_VERSION=3.6

clean:
	rm Dockerfile || true

Dockerfile: Dockerfile.template
	sed \
		-e 's!{{ .PyPyVersion }}!'"$(PYPY_VERSION)"'!g' \
		-e 's!{{ .AlpineVersion }}!'"$(ALPINE_VERSION)"'!g' \
		Dockerfile.template > Dockerfile

build: Dockerfile
	docker build .
