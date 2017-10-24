FROM debian:stretch
MAINTAINER Camptocamp

ENV DEBIAN_FRONTEND=noninteractive \
    POSTFIX_MAIL_NAME=odoo.test.ch \
    POSTFIX_MY_DESTINATION=odoo.test.ch

RUN adduser ${POSTFIX_MAIL_NAME}.mailgate --disabled-login --system --force-badname
RUN apt-get update \
    && apt-get install -q -y --no-install-recommends \
        rsyslog \
        postfix vim telnet \
    && postconf -e myhostname=$POSTFIX_MAIL_NAME \
    && echo $POSTFIX_MAIL_NAME'.mailgate: "|/test_mailgate.sh"' >> /etc/aliases \
    && echo "@$POSTFIX_MAIL_NAME $POSTFIX_MAIL_NAME.mailgate" > /etc/postfix/virtual_aliases \
    && postconf -e virtual_alias_maps=hash:/etc/postfix/virtual_aliases \
    && postconf -e alias_maps=hash:/etc/aliases \
    && postconf -e alias_database=hash:/etc/aliases \
    && postmap /etc/postfix /etc/postfix/virtual_aliases \
    && newaliases

EXPOSE 25 465 587

COPY docker-entrypoint.sh /docker-entrypoint.sh
COPY openerp_mailgate.py /openerp_mailgate.py
COPY test_mailgate.sh /test_mailgate.sh

ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["tail", "-F", "/var/log/mail.log"]
