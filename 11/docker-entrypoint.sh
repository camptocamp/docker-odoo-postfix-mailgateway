#!/bin/bash

set -e

/usr/sbin/postfix stop
/usr/sbin/postfix start

exec "$@"
