DEBIAN_VERSION ?= 13
PHP_VERSION    ?= 8.4
SWOOLE_VERSION ?= 6.1.5
GRPC_VERSION   ?= 1.76.0
PLATFORMS      ?= linux/amd64,linux/arm64
HTTP_PROXY     ?=
HTTPS_PROXY    ?=

BASE_TAG   = dmcz0/php:$(PHP_VERSION)-dev-debian-$(DEBIAN_VERSION)
SWOOLE_TAG = $(BASE_TAG)-swoole-$(SWOOLE_VERSION)
GRPC_TAG   = $(SWOOLE_TAG)-grpc-$(GRPC_VERSION)

BUILD_ARGS = \
	--build-arg DEBIAN_VERSION=$(DEBIAN_VERSION) \
	--build-arg PHP_VERSION=$(PHP_VERSION) \
	--build-arg HTTP_PROXY=$(HTTP_PROXY) \
	--build-arg HTTPS_PROXY=$(HTTPS_PROXY)

.PHONY: all build-base build-swoole build-grpc \
	buildx-base buildx-swoole buildx-grpc

all: build-base build-swoole build-grpc

build-base:
	docker build . -t $(BASE_TAG) $(BUILD_ARGS)

build-swoole:
	docker build ./swoole -t $(SWOOLE_TAG) \
		$(BUILD_ARGS) \
		--build-arg SWOOLE_VERSION=$(SWOOLE_VERSION)

build-grpc:
	docker build ./swoole/grpc -t $(GRPC_TAG) \
		$(BUILD_ARGS) \
		--build-arg SWOOLE_VERSION=$(SWOOLE_VERSION) \
		--build-arg GRPC_VERSION=$(GRPC_VERSION)

# Multi-arch build (requires buildx and typically --push)
buildx-base:
	docker buildx build ./ -t $(BASE_TAG) \
		--platform $(PLATFORMS) \
		$(BUILD_ARGS) \
		--push

buildx-swoole:
	docker buildx build ./swoole -t $(SWOOLE_TAG) \
		--platform $(PLATFORMS) \
		$(BUILD_ARGS) \
		--build-arg SWOOLE_VERSION=$(SWOOLE_VERSION) \
		--push

buildx-grpc:
	docker buildx build ./swoole/grpc -t $(GRPC_TAG) \
		--platform $(PLATFORMS) \
		$(BUILD_ARGS) \
		--build-arg SWOOLE_VERSION=$(SWOOLE_VERSION) \
		--build-arg GRPC_VERSION=$(GRPC_VERSION) \
		--push
