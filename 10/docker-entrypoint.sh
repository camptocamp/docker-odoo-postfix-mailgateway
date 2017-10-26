#!/bin/bash

set -e

service rsyslog start

/usr/sbin/postfix stop
/usr/sbin/postfix start

exec "$@"
