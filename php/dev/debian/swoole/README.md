# build command example
```bash
docker build . -t dmcz0/php:8.4-dev-debian-13-swoole-6.1.5 \
--build-arg DEBIAN_VERSION=13 \
--build-arg PHP_VERSION_MAJOR=8 \
--build-arg PHP_VERSION_MINOR=4 \
--build-arg PHP_VERSION_PATCH=0 \
--build-arg SWOOLE_VERSION=6.1.5 \
--build-arg HTTP_PROXY=http://172.29.112.1:7890 \
--build-arg HTTPS_PROXY=http://172.29.112.1:7890
```
