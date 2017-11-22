#!/bin/bash

# Run the postfix images with some default params

docker run \
    -e POSTFIX_MAIL_NAME=odoo.test.ch \
    -e ODOO_HOST=172.22.0.3 \
    -e ODOO_DB_NAME=odoodb \
    -e ODOO_USER_ID=1 \
    -e ODOO_USER_PWD=admin \
    -e ODOO_MODEL=project_project \
    --rm --name postfix docker-odoo-postfix:latest

