docker build -t docker-odoo-postfix:latest ./11

docker stop postfix
docker rm postfix

docker run --name postfix -t -d docker-odoo-postfix:latest /bin/bash

