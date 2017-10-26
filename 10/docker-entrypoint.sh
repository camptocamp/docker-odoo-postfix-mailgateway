#!/bin/bash

set -e

service rsyslog start
postfix stop
postfix start

postconf -e myhostname=$POSTFIX_MAIL_NAME
postconf -e virtual_alias_maps=hash:/etc/postfix/virtual_aliases
postconf -e alias_maps=hash:/etc/aliases
postconf -e alias_database=hash:/etc/aliases

# Setup the command that is called for redirected emails
CALL_MAILGATE="|/openerp_mailgate.py --host=$ODOO_HOST --dbname=$ODOO_DB_NAME -u $ODOO_USER_ID -p $ODOO_USER_PWD -o $ODOO_MODEL"
echo 'odoomailgate: "'$CALL_MAILGATE'"' >> /etc/aliases
# Redirect all emails to the mailgate user
echo "@$POSTFIX_MAIL_NAME odoomailgate" > /etc/postfix/virtual_aliases

# Reload configuration
postmap /etc/postfix /etc/postfix/virtual_aliases
newaliases
postfix reload

exec "$@"
