# build command example
```bash
docker build . -t dmcz0/php:8.2-dev-ubuntu-22.04-swow-1.3.1 \
--build-arg UBUNTU_VERSION=22.04 \
--build-arg PHP_VERSION=8.2 \
--build-arg SWOW_VERISON=1.3.1 \
--build-arg HTTP_PROXY=http://172.29.112.1:7890 \
--build-arg HTTPS_PROXY=http://172.29.112.1:7890
```