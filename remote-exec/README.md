# curl-exec

```bash
// echo "abc"
docker run --rm -it -p 9999:9999 -e "MAIN_SHA256=fw34ra..." empirefoxit/remote-exec http://xxx/echo.tar.gz "abc"
```

`MAIN_SHA256` must be set, and `echo.tar.gz` must contain a executable named main
