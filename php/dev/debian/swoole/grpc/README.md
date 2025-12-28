# build command example
```bash
docker build . -t dmcz0/php:8.4-dev-debian-13-swoole-6.1.5-grpc-1.76.0 \
--build-arg DEBIAN_VERSION=13 \
--build-arg PHP_VERSION=8.4 \
--build-arg SWOOLE_VERSION=6.1.5 \
--build-arg GRPC_VERSION=1.76.0 \
--build-arg HTTP_PROXY=http://172.29.112.1:7890 \
--build-arg HTTPS_PROXY=http://172.29.112.1:7890
```