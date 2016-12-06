#!/bin/sh
set -e

curl -sSL -o /rmain $1
chmod a+x /rmain

shift
exec /rmain "$@"
