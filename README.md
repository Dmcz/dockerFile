# docker hub images
* dmcz0/php:7.4-dev-ubuntu-22.04
* dmcz0/php:7.4-dev-ubuntu-22.04-swoole-4.8.12
* dmcz0/php:8.2-dev-ubuntu-22.04
* dmcz0/php:8.2-dev-ubuntu-22.04-swoole-5.1.0
* > 待调整 dmcz0/php:8.2-dev-ubuntu-22.04-swoole-5.1.0-grpc-1.59.1

# example of build command
```bash
docker build . -t dmcz0/php:8.2-dev-ubuntu-22.04 \
--build-arg UBUNTU_VERSION=22.04 \
--build-arg PHP_VERSION=8.2 \
--build-arg HTTP_PROXY=http://172.29.112.1:7890 \
--build-arg HTTPS_PROXY=http://172.29.112.1:7890
```
* 其中代理需要监听LAN，既非仅127.0.0.1
