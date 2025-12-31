# build command example (non-zts)
```bash
docker build . -t dmcz0/php:8.4-dev-debian-13 \
--build-arg DEBIAN_VERSION=13 \
--build-arg PHP_VERSION_MAJOR=8 \
--build-arg PHP_VERSION_MINOR=4 \
--build-arg PHP_VERSION_PATCH=0 \
--build-arg HTTP_PROXY=http://192.168.3.23:7890 \
--build-arg HTTPS_PROXY=http://192.168.3.23:7890
```

# build command example (zts)
```bash
docker build -f dockerfile-zts . -t dmcz0/php:8.4-dev-debian-13-zts \
--build-arg DEBIAN_VERSION=13 \
--build-arg PHP_VERSION_MAJOR=8 \
--build-arg PHP_VERSION_MINOR=4 \
--build-arg PHP_VERSION_PATCH=0 \
--build-arg HTTP_PROXY=http://192.168.3.23:7890 \
--build-arg HTTPS_PROXY=http://192.168.3.23:7890
```

# make example (zts)
```bash
make -C php/dev/debian build-base \
  DEBIAN_VERSION=13 \
  PHP_VERSION=8.4.0 \
  ZTS=1 \
  HTTP_PROXY=http://192.168.3.23:7890 \
  HTTPS_PROXY=http://192.168.3.23:7890
```
