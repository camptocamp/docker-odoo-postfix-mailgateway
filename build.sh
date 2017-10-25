docker build -t docker-odoo-postfix:latest ./11

docker stop postfix
docker rm postfix

# docker run --rm --name postfix docker-odoo-postfix:latest &

