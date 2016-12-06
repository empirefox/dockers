#!/bin/sh

curl -sSL -o /rmain $1
chmod a+x /rmain

shift
exec /rmain "$@"
