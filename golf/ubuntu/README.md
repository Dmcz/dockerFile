# build command example
```bash
docker build . -t dmcz0/golf:ubuntu-0.0.3 \
--build-arg HTTP_PROXY=http://172.23.192.1:7890 \
--build-arg HTTPS_PROXY=http://172.23.192.1:7890
```