# golang-toxcore-arm-linux

```bash
docker build -t empirefoxit/golang-toxcore-arm-linux golang-toxcore-arm-linux

docker run --rm -it \
  -v $GOPATH/src:/go/src \
  empirefoxit/golang-toxcore-arm-linux  \
  build \
  test.com/empirefox/cmd/test
```

```bash
$ ls $GOPATH/src/test.com/empirefox/cmd/test
test-arm test-arm64
```