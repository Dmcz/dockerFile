# build command example
```bash
docker build . -t dmcz0/php:8.2-dev-ubuntu-22.04-swoole-5.1.0-grpc-1.59.1 \
--build-arg UBUNTU_VERSION=22.04 \
--build-arg PHP_VERSION=8.2 \
--build-arg SWOOLE_VERSION=5.1.0 \
--build-arg GRPC_VERSION=1.59.1 \
--build-arg HTTP_PROXY=http://172.29.112.1:7890 \
--build-arg HTTPS_PROXY=http://172.29.112.1:7890
```

# docker file 待调整