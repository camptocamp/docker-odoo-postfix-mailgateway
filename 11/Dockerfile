FROM debian:stretch
MAINTAINER Camptocamp

ENV DEBIAN_FRONTEND=noninteractive \
    POSTFIX_MAIL_NAME=odoo.test.ch \
    POSTFIX_MY_DESTINATION=odoo.test.ch

#run echo "postfix postfix/main_mailer_type string Internet site" > preseed.txt
#run echo "postfix postfix/mailname string $POSTFIX_MAIL_NAME" >> preseed.txt

RUN apt-get update \
#    && debconf-set-selections preseed.txt \
#    && apt-get install -q -y apt-utils \
#    && DEBIAN_FRONTEND=noninteractive apt-get install -q -y postfix vim \
    && apt-get install -q -y --no-install-recommends \
        rsyslog \
        postfix vim telnet \
    && postconf -e myhostname=$POSTFIX_MAIL_NAME \
#    && postconf -e virtual_alias_maps=/etc/postfix/virtual_aliases \
    && postconf -e alias_maps=hash:/etc/aliases \
    && postconf -e alias_database=hash:/etc/aliases \
    && echo "$POSTFIX_MAIL_NAME.mailgate: '|/test_mailgate.sh'" >> /etc/aliases \
    && echo "@$POSTFIX_MAIL_NAME $POSTFIX_MAIL_NAME.mailgate@localhost" > /etc/postfix/virtual_aliases
RUN adduser ${POSTFIX_MAIL_NAME}.mailgate --disabled-login --system --force-badname

    #&& rm preseed.txt


EXPOSE 25 465 587

COPY docker-entrypoint.sh /docker-entrypoint.sh
COPY openerp_mailgate.py /openerp_mailgate.py
COPY test_mailgate.sh /test_mailgate.sh

ENTRYPOINT ["/docker-entrypoint.sh"]

# CMD ["/usr/sbin/postfix", "start"]
