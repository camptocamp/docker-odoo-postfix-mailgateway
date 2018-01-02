FROM debian:stretch
MAINTAINER Camptocamp

ENV DEBIAN_FRONTEND=noninteractive \
    POSTFIX_HOSTNAME=odoo.postfix.local

RUN apt-get update \
    && apt-get install -q -y --no-install-recommends \
        jq \
        rsyslog \
        postfix \
        python \
        # Only here for debug
        vim telnet procps

VOLUME "/var/spool/postfix"

EXPOSE 25

COPY root /

ENTRYPOINT ["/docker-entrypoint.sh"]
