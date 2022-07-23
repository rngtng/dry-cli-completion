PROJECT     ?= rngtng/dry-cli-completion
BUILD_TAG   ?= dev
REGISTRY_TAG = $(PROJECT):$(BUILD_TAG)

.PHONY: help # List all documented targets
help:
	@grep '^.PHONY: .* #' Makefile | sed 's/\.PHONY: \(.*\) # \(.*\)/\1 $(shell echo "\t") \2/' | sort | expand -t20

.PHONY: build # Build docker image with `dev` tag
build:
	docker build -t $(REGISTRY_TAG) .

.PHONY: test-gh-action # Test github actions locally with https://github.com/nektos/act
test-gh-action:
  echo '{ "inputs": { "tag": "0.1.0" } }' > /tmp/act.json
	act --artifact-server-path /tmp/artifacts workflow_dispatch -e /tmp/act.json

.PHONY: dev # Build docker image, run and ssh inside
dev:
	docker run --rm -it -v "$(shell pwd):/app" $(REGISTRY_TAG)
