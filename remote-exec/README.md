# remote-exec

```bash
// echo "abc"
docker run --rm -it \
 -p 9999:9999 \
 -e "MAIN_SHA256=fw34ra..." \
 -e "MAIN_URL=http://xxx/echo.tar.gz" \
 empirefoxit/remote-exec "abc"
```

`MAIN_SHA256` and `MAIN_URL` must be set, and `echo.tar.gz` must contain a executable named `main`
