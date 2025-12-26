# build command example
```bash
docker build . -t dmcz0/php:8.2-dev-ubuntu-24.04 \
--build-arg UBUNTU_VERSION=24.04 \
--build-arg PHP_VERSION=8.3 \
--build-arg HTTP_PROXY=http://172.29.112.1:7890 \
--build-arg HTTPS_PROXY=http://172.29.112.1:7890
```