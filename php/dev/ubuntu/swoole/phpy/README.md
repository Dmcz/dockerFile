# build command example
```bash
docker build . -t dmcz0/php:8.3-dev-ubuntu-24.04-swoole-5.1.2-python-3.11-phpy-1.0.4 \
--build-arg UBUNTU_VERSION=24.04 \
--build-arg PHP_VERSION=8.3 \
--build-arg SWOOLE_VERSION=5.1.2 \
--build-arg PHPY_VERSION=1.0.5 \
--build-arg PYTHON_VERSION=3.11.9 \
--build-arg HTTP_PROXY=http://172.18.80.1:7890 \
--build-arg HTTPS_PROXY=http://172.18.80.1:7890
```
* ubuntu 24.04中默认包含了python3.12
* 如果使用python3.12 安装py包需要使用apt而不是pip