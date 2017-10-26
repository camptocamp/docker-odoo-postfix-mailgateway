FROM debian:stretch
MAINTAINER Camptocamp

ENV DEBIAN_FRONTEND=noninteractive \
    POSTFIX_MAIL_NAME=odoo.test.ch \
    ODOO_DB_NAME=odoodb \
    ODOO_HOST=odoo \
    ODOO_USER_ID=1 \
    ODOO_USER_PWD=admin \
    ODOO_MODEL=project.project

RUN adduser odoomailgate --disabled-login --system --force-badname
RUN apt-get update \
    && apt-get install -q -y --no-install-recommends \
        rsyslog \
        postfix \
        python \
        # Only here for testing
        vim telnet

EXPOSE 25

COPY docker-entrypoint.sh /docker-entrypoint.sh
COPY openerp_mailgate.py /openerp_mailgate.py
COPY test_mailgate.sh /test_mailgate.sh

ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["tail", "-F", "/var/log/mail.log"]
