#!/bin/bash

set -e

service rsyslog start

# Empty config files so we can reconstruct them
> /etc/postfix/virtual_aliases
echo "postmaster: root" > /etc/aliases
MYDESTINATION=

for client in $(echo "$CLIENT_INSTANCE" | jq -c '.[]'); do
    NAME=$(echo ${client} | jq -r '.name')
    DOMAIN=$(echo ${client} | jq -r '.domain')
    ODOO_HOST=$(echo ${client} | jq -r '.odoo_host')
    ODOO_DB=$(echo ${client} | jq -r '.odoo_db')
    ODOO_USER_ID=$(echo ${client} | jq -r '.odoo_user_id')
    ODOO_USER_PWD=$(echo ${client} | jq -r '.odoo_user_pwd')
    ODOO_MODEL=$(echo ${client} | jq -r '.odoo_model')

    echo "@$DOMAIN $NAME-MailGate" >> /etc/postfix/virtual_aliases

    CALL_MAILGATE="|/openerp_mailgate.py --host=$ODOO_HOST --dbname=$ODOO_DB -u $ODOO_USER_ID -p $ODOO_USER_PWD" # -o $ODOO_MODEL"
    echo $NAME'-MailGate: "'$CALL_MAILGATE'"' >> /etc/aliases

    MYDESTINATION="$MYDESTINATION, $DOMAIN"
    adduser $NAME'-MailGate' --disabled-login --system --force-badname --no-create-home
done

postconf -e myhostname=$POSTFIX_HOSTNAME
postconf -e virtual_alias_maps=hash:/etc/postfix/virtual_aliases
postconf -e alias_maps=hash:/etc/aliases
postconf -e alias_database=hash:/etc/aliases
postconf -e recipient_delimiter=+
postconf -e "mydestination=$POSTFIX_HOSTNAME, localhost$MYDESTINATION"

postmap /etc/postfix /etc/postfix/virtual_aliases
newaliases
postfix start

exec "$@"
