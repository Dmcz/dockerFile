DEBIAN_VERSION ?= 13
PHP_VERSION    ?= 8.4.16
PHP_ZTS        ?= 0
SWOOLE_VERSION ?= 6.1.5
SWOOLE_THREAD  ?= 0
GRPC_VERSION   ?= 1.76.0
PLATFORMS      ?=
PLATFORM       ?=
HTTP_PROXY     ?=
HTTPS_PROXY    ?=

PHP_VERSION_MAJOR = $(word 1,$(subst ., ,$(PHP_VERSION)))
PHP_VERSION_MINOR = $(word 2,$(subst ., ,$(PHP_VERSION)))
PHP_VERSION_PATCH = $(word 3,$(subst ., ,$(PHP_VERSION)))

ifeq ($(PHP_VERSION_MINOR),)
$(error PHP_VERSION must be x.y or x.y.z (minor is required))
endif
ifeq ($(PHP_VERSION_PATCH),)
PHP_VERSION_PATCH = 0
endif

PHP_VERSION_SHORT = $(PHP_VERSION_MAJOR).$(PHP_VERSION_MINOR)
PHP_VERSION_FULL  = $(PHP_VERSION_MAJOR).$(PHP_VERSION_MINOR).$(PHP_VERSION_PATCH)

ifeq ($(PHP_ZTS),1)
PHP_ZTS_SUFFIX = -zts
else
PHP_ZTS_SUFFIX =
endif

BASE_DOCKERFILE = ./dockerfile
BASE_TAG   = dmcz0/php:$(PHP_VERSION_FULL)-dev-debian-$(DEBIAN_VERSION)$(PHP_ZTS_SUFFIX)
ifeq ($(SWOOLE_THREAD),1)
SWOOLE_THREAD_SUFFIX = -thread
else
SWOOLE_THREAD_SUFFIX =
endif
SWOOLE_TAG = $(BASE_TAG)-swoole-$(SWOOLE_VERSION)$(SWOOLE_THREAD_SUFFIX)
GRPC_TAG   = $(SWOOLE_TAG)-grpc-$(GRPC_VERSION)
SWOOLE_BASE_IMAGE = $(BASE_TAG)
GRPC_BASE_IMAGE   = $(SWOOLE_TAG)

BUILD_ARGS = \
	--build-arg DEBIAN_VERSION=$(DEBIAN_VERSION) \
	--build-arg PHP_VERSION_MAJOR=$(PHP_VERSION_MAJOR) \
	--build-arg PHP_VERSION_MINOR=$(PHP_VERSION_MINOR) \
	--build-arg PHP_VERSION_PATCH=$(PHP_VERSION_PATCH) \
	--build-arg PHP_ZTS=$(PHP_ZTS) \
	--build-arg HTTP_PROXY=$(HTTP_PROXY) \
	--build-arg HTTPS_PROXY=$(HTTPS_PROXY)

ifneq ($(strip $(PLATFORM)),) # 指定单平台
BUILD_CMD = docker build
BUILD_PLATFORM = --platform $(PLATFORM)
BUILD_OUTPUT =
else ifneq ($(strip $(PLATFORMS)),) # 多平台
BUILD_CMD = docker buildx build
BUILD_PLATFORM = --platform $(PLATFORMS)
BUILD_OUTPUT = --push
else # 默认为当前平台
BUILD_CMD = docker build
BUILD_PLATFORM =
BUILD_OUTPUT =
endif

.PHONY: all buildx-base buildx-swoole buildx-grpc

all: buildx-base buildx-swoole buildx-grpc

buildx-base:
	$(BUILD_CMD) ./ -f $(BASE_DOCKERFILE) -t $(BASE_TAG) \
		$(BUILD_PLATFORM) \
		$(BUILD_ARGS) \
		$(BUILD_OUTPUT)

buildx-swoole:
	$(BUILD_CMD) ./swoole -t $(SWOOLE_TAG) \
		$(BUILD_PLATFORM) \
		$(BUILD_ARGS) \
		--build-arg BASE_IMAGE=$(SWOOLE_BASE_IMAGE) \
		--build-arg SWOOLE_VERSION=$(SWOOLE_VERSION) \
		--build-arg SWOOLE_THREAD=$(SWOOLE_THREAD) \
		$(BUILD_OUTPUT)

buildx-grpc:
	$(BUILD_CMD) ./swoole/grpc -t $(GRPC_TAG) \
		$(BUILD_PLATFORM) \
		$(BUILD_ARGS) \
		--build-arg BASE_IMAGE=$(GRPC_BASE_IMAGE) \
		--build-arg SWOOLE_VERSION=$(SWOOLE_VERSION) \
		--build-arg GRPC_VERSION=$(GRPC_VERSION) \
		$(BUILD_OUTPUT)
