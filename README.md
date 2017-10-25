# docker-odoo-postfix

A Docker image wich runs Postfix as a MTA in front of Odoo, all email received for the configured host name are redirected to the openerp_mailgate.py Odoo script.


## Configuration

Port 25 is exposed by default.
The preconfigured domain name is odoo.test.ch, to change this use environment variable described below.

### Environment variables

#### `POSTFIX_MAIL_NAME`
Set up the domain name the Postfix deamon will answer to.


### DNS
The idea is to add a subdomain (odoo) to the official domain name of the client (ex.: odoo.camptocamp.com)
And route all email with this subdomain to the Postfix instance.
???

## ToDo

### Set up postfix on first start not in Dockerfile

### Add openerp_mailgate.py
  * Add python dependencies
  * Add script
  * Connect postfix container to odoo container
  * Add to env user, pwd
