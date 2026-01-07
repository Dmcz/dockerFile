DEBIAN_VERSION ?= 13
PHP_VERSION    ?= 8.4.16
PHP_ZTS        ?= 0
SWOOLE_VERSION ?= 6.1.5
SWOOLE_THREAD  ?= 0
GRPC_VERSION   ?=
PROTOBUF_VERSION ?=
# 暂时默认单平台，因为跨平台在编译时一只存在问题，怀疑是仿真哪里有问题。
# 如果解决掉问题后，则默认多平台：macOS(Apple Silicon) -> linux/arm64，Intel/AMD -> linux/amd64
PLATFORMS      ?= 
HTTP_PROXY     ?=
HTTPS_PROXY    ?=
MAKEFLAGS      ?= -j$(shell nproc)
COMMA          := ,

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
PLATFORM_TAG_PREFIX =
ifneq ($(strip $(PLATFORMS)),)
ifeq ($(findstring $(COMMA),$(PLATFORMS)),)
PLATFORM_TAG_PREFIX = $(patsubst linux/%,%,$(PLATFORMS))-
endif
else
HOST_ARCH = $(shell uname -m)
ifeq ($(HOST_ARCH),x86_64)
PLATFORM_TAG_PREFIX = amd64-
else ifeq ($(HOST_ARCH),aarch64)
PLATFORM_TAG_PREFIX = arm64-
else ifeq ($(HOST_ARCH),arm64)
PLATFORM_TAG_PREFIX = arm64-
endif
endif
BASE_TAG   = dmcz0/php-dev:$(PHP_VERSION_FULL)$(PHP_ZTS_SUFFIX)-$(PLATFORM_TAG_PREFIX)debian-$(DEBIAN_VERSION)
ifeq ($(SWOOLE_THREAD),1)
SWOOLE_THREAD_SUFFIX = -thread
else
SWOOLE_THREAD_SUFFIX =
endif
SWOOLE_TAG = $(BASE_TAG)-swoole-$(SWOOLE_VERSION)$(SWOOLE_THREAD_SUFFIX)
ifneq ($(strip $(GRPC_VERSION)),)
GRPC_TAG_SUFFIX = -grpc-$(GRPC_VERSION)
else
GRPC_TAG_SUFFIX = -grpc
endif
GRPC_TAG   = $(SWOOLE_TAG)$(GRPC_TAG_SUFFIX)
SWOOLE_BASE_IMAGE = $(BASE_TAG)
GRPC_BASE_IMAGE   = $(SWOOLE_TAG)

BUILD_ARGS = \
	--build-arg DEBIAN_VERSION=$(DEBIAN_VERSION) \
	--build-arg PHP_VERSION_MAJOR=$(PHP_VERSION_MAJOR) \
	--build-arg PHP_VERSION_MINOR=$(PHP_VERSION_MINOR) \
	--build-arg PHP_VERSION_PATCH=$(PHP_VERSION_PATCH) \
	--build-arg PHP_ZTS=$(PHP_ZTS) \
	--build-arg MAKEFLAGS=$(MAKEFLAGS) \
	--build-arg HTTP_PROXY=$(HTTP_PROXY) \
	--build-arg HTTPS_PROXY=$(HTTPS_PROXY)

ifneq ($(strip $(PLATFORMS)),) # 指定平台
ifneq ($(findstring $(COMMA),$(PLATFORMS)),) # 多平台
BUILD_CMD = docker buildx build
BUILD_PLATFORM = --platform $(PLATFORMS)
BUILD_OUTPUT = --push
else # 单平台
BUILD_CMD = docker build
BUILD_PLATFORM = --platform $(PLATFORMS)
BUILD_OUTPUT =
endif
else # 默认为当前平台
BUILD_CMD = docker build
BUILD_PLATFORM =
BUILD_OUTPUT =
endif

.PHONY: all base swoole swoole-grpc

all: base swoole swoole-grpc

base:
	$(BUILD_CMD) -f $(BASE_DOCKERFILE) -t $(BASE_TAG) \
		$(BUILD_PLATFORM) \
		$(BUILD_ARGS) \
		$(BUILD_OUTPUT) \
		./

swoole:
	$(BUILD_CMD) -t $(SWOOLE_TAG) \
		$(BUILD_PLATFORM) \
		$(BUILD_ARGS) \
		--build-arg BASE_IMAGE=$(SWOOLE_BASE_IMAGE) \
		--build-arg SWOOLE_VERSION=$(SWOOLE_VERSION) \
		--build-arg SWOOLE_THREAD=$(SWOOLE_THREAD) \
		$(BUILD_OUTPUT) \
		./swoole

swoole-grpc:
	$(BUILD_CMD) -t $(GRPC_TAG) \
		$(BUILD_PLATFORM) \
		$(BUILD_ARGS) \
		--build-arg BASE_IMAGE=$(GRPC_BASE_IMAGE) \
		--build-arg SWOOLE_VERSION=$(SWOOLE_VERSION) \
		--build-arg GRPC_VERSION=$(GRPC_VERSION) \
		--build-arg PROTOBUF_VERSION=$(PROTOBUF_VERSION) \
		$(BUILD_OUTPUT) \
		./swoole/grpc
