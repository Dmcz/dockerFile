# build command example
```bash
docker build . -t dmcz0/php:8.4-dev-debian-13 \
--build-arg DEBIAN_VERSION=13 \
--build-arg PHP_VERSION=8.4 \
--build-arg HTTP_PROXY=http://192.168.3.23:7890 \
--build-arg HTTPS_PROXY=http://192.168.3.23:7890
```

# make example
```bash
make -C php/dev/debian build-base \
  DEBIAN_VERSION=13 \
  PHP_VERSION=8.4 \
  HTTP_PROXY=http://192.168.3.23:7890 \
  HTTPS_PROXY=http://192.168.3.23:7890
```
