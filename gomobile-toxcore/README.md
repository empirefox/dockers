# gomobile-toxcore

```bash
docker build -t empirefoxit/gomobile-ndk gomobile-ndk
docker build -t empirefoxit/gomobile-toxcore gomobile-toxcore

docker run --rm -it \
  -v $GOPATH/src:/go/src \
  empirefoxit/gomobile-toxcore \
  aar \
  test.com/empirefox/cgo-android
```

then cgo-android.aar file will be there