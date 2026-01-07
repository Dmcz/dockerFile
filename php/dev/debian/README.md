# make example
## 推荐构建示例
```bash
make -C php/dev/debian all \
  DEBIAN_VERSION=13 \
  PHP_VERSION=8.4.16 \
  SWOOLE_VERSION=6.1.5 \
  MAKEFLAGS=-j5 \
  HTTP_PROXY=http://192.168.5.2:7890 \
  HTTPS_PROXY=http://192.168.5.2:7890 
```
## Swoole多线程
```bash
make -C php/dev/debian swoole \
  DEBIAN_VERSION=13 \
  PHP_VERSION=8.4.16 \
  PHP_ZTS=1 \
  SWOOLE_VERSION=6.1.5 \
  SWOOLE_THREAD=1 \
  MAKEFLAGS=-j5 \
  HTTP_PROXY=http://192.168.5.2:7890 \
  HTTPS_PROXY=http://192.168.5.2:7890 
```
## 全部参数的构建示例 
> GRPC_VERSION 和  PROTOBUF_VERSION 可以不指定，默认为最新。
```bash
make -C php/dev/debian all \
  DEBIAN_VERSION=13 \
  PHP_VERSION=8.4.16 \
  PHP_ZTS=1 \
  SWOOLE_VERSION=6.1.5 \
  SWOOLE_THREAD=1 \
  GRPC_VERSION=1.76.0 \
  PROTOBUF_VERSION=4.33.2 \
  MAKEFLAGS=-j5 \
  HTTP_PROXY=http://192.168.5.2:7890 \
  HTTPS_PROXY=http://192.168.5.2:7890 
```

# platform 说明
- 默认不设置 `PLATFORMS`：使用 `docker build`，当前平台
- 设置 `PLATFORMS=linux/amd64`：使用 `docker build` 单平台构建
- 设置 `PLATFORMS=linux/amd64,linux/arm64`：使用 `docker buildx build` 多平台构建并 `--push`

# build command example
## php/dev/debian/dockerfile
```bash
docker build ./php/dev/debian -t dmcz0/php-dev:8.4.16-zts-debian-13 \
  --build-arg DEBIAN_VERSION=13 \
  --build-arg PHP_VERSION_MAJOR=8 \
  --build-arg PHP_VERSION_MINOR=4 \
  --build-arg PHP_VERSION_PATCH=16 \
  --build-arg PHP_ZTS=1 \
  --build-arg MAKEFLAGS=-j16 \
  --build-arg HTTP_PROXY=http://192.168.3.23:7890 \
  --build-arg HTTPS_PROXY=http://192.168.3.23:7890
```

## php/dev/debian/swoole/dockerfile
```bash
docker build ./php/dev/debian/swoole -t dmcz0/php-dev:8.4.16-zts-debian-13-swoole-6.1.5-thread \
  --build-arg BASE_IMAGE=dmcz0/php-dev:8.4.16-zts-debian-13 \
  --build-arg SWOOLE_VERSION=6.1.5 \
  --build-arg SWOOLE_THREAD=1 
```

## php/dev/debian/swoole/grpc/dockerfile
** 固定版本
```bash
docker build ./php/dev/debian/swoole/grpc -t dmcz0/php-dev:8.4.16-zts-debian-13-swoole-6.1.5-thread-grpc-1.76.0 \
  --build-arg BASE_IMAGE=dmcz0/php-dev:8.4.16-zts-debian-13-swoole-6.1.5-thread \
  --build-arg GRPC_VERSION=1.76.0 \
  --build-arg PROTOBUF_VERSION=4.33.2
```
