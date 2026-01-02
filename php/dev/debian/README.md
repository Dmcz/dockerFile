# make example
**  构建多线程swool
```bash
make -C php/dev/debian all \
  DEBIAN_VERSION=13 \
  PHP_VERSION=8.4.0 \
  PHP_ZTS=1 \
  SWOOLE_VERSION=1.6.5 \
  SWOOLE_THREAD=1 \
  HTTP_PROXY=http://192.168.3.8:7890 \
  HTTPS_PROXY=http://192.168.3.8:7890
```

# platform 说明
- 默认不设置 `PLATFORM` / `PLATFORMS`：使用 `docker build`，当前平台
- 设置 `PLATFORM=linux/amd64`：使用 `docker build` 单平台构建
- 设置 `PLATFORMS=linux/amd64,linux/arm64`：使用 `docker buildx build` 多平台构建并 `--push`

# build command example
```bash
docker build . -t dmcz0/php:8.4-dev-debian-13-zts \
--build-arg DEBIAN_VERSION=13 \
--build-arg PHP_VERSION_MAJOR=8 \
--build-arg PHP_VERSION_MINOR=4 \
--build-arg PHP_VERSION_PATCH=0 \
--build-arg PHP_ZTS=1 \
--build-arg HTTP_PROXY=http://192.168.3.23:7890 \
--build-arg HTTPS_PROXY=http://192.168.3.23:7890
```
