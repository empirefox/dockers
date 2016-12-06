#!/bin/sh
set -e

wget -q "$1" -O main.tar.gz
echo "$MAIN_SHA256  main.tar.gz" | sha256sum -c -
tar -C / -xzf main.tar.gz
rm main.tar.gz

chmod a+x /main

shift
exec /main "$@"
