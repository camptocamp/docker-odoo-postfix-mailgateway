#!/bin/bash

# Build a new image

docker build -t docker-odoo-postfix:latest ./10


# If you want a container created and started after the build

# docker stop postfix
# docker rm postfix
# docker run --rm --name postfix docker-odoo-postfix:latest

