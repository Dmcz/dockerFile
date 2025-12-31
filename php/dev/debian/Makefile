DEBIAN_VERSION ?= 13
PHP_VERSION    ?= 8.4.0
SWOOLE_VERSION ?= 6.1.5
GRPC_VERSION   ?= 1.76.0
PLATFORMS      ?= linux/amd64,linux/arm64
HTTP_PROXY     ?=
HTTPS_PROXY    ?=
ZTS            ?= 0

PHP_VERSION_MAJOR = $(word 1,$(subst ., ,$(PHP_VERSION)))
PHP_VERSION_MINOR = $(word 2,$(subst ., ,$(PHP_VERSION)))
PHP_VERSION_PATCH = $(word 3,$(subst ., ,$(PHP_VERSION)))

ifeq ($(PHP_VERSION_MINOR),)
PHP_VERSION_MINOR = 4
endif
ifeq ($(PHP_VERSION_PATCH),)
PHP_VERSION_PATCH = 0
endif

PHP_VERSION_SHORT = $(PHP_VERSION_MAJOR).$(PHP_VERSION_MINOR)
PHP_VERSION_FULL  = $(PHP_VERSION_MAJOR).$(PHP_VERSION_MINOR).$(PHP_VERSION_PATCH)

ifeq ($(ZTS),1)
ZTS_SUFFIX = -zts
BASE_DOCKERFILE = ./dockerfile-zts
else
ZTS_SUFFIX =
BASE_DOCKERFILE = ./dockerfile
endif

BASE_TAG   = dmcz0/php:$(PHP_VERSION_SHORT)-dev-debian-$(DEBIAN_VERSION)$(ZTS_SUFFIX)
SWOOLE_TAG = $(BASE_TAG)-swoole-$(SWOOLE_VERSION)
GRPC_TAG   = $(SWOOLE_TAG)-grpc-$(GRPC_VERSION)

BUILD_ARGS = \
	--build-arg DEBIAN_VERSION=$(DEBIAN_VERSION) \
	--build-arg PHP_VERSION_MAJOR=$(PHP_VERSION_MAJOR) \
	--build-arg PHP_VERSION_MINOR=$(PHP_VERSION_MINOR) \
	--build-arg PHP_VERSION_PATCH=$(PHP_VERSION_PATCH) \
	--build-arg ZTS_SUFFIX=$(ZTS_SUFFIX) \
	--build-arg HTTP_PROXY=$(HTTP_PROXY) \
	--build-arg HTTPS_PROXY=$(HTTPS_PROXY)

.PHONY: all build-base build-swoole build-grpc \
	buildx-base buildx-swoole buildx-grpc

all: build-base build-swoole build-grpc

build-base:
	docker build -f $(BASE_DOCKERFILE) . -t $(BASE_TAG) $(BUILD_ARGS)

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
	docker buildx build ./ -f $(BASE_DOCKERFILE) -t $(BASE_TAG) \
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
