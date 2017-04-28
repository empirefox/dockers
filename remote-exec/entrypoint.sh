#!/bin/sh
set -e

wget -q "$MAIN_URL" -O main.tar.gz
echo "$MAIN_SHA256  main.tar.gz" | sha256sum -c -
tar -C / -xzf main.tar.gz
rm main.tar.gz

chmod a+x /main
exec /main "$@"
