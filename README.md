# docker-odoo-postfix

A Docker image that runs Postfix as a MTA in front of Odoo.
All email received for the configured host name are redirected to the openerp_mailgate.py Odoo script, which send them to the Odoo instance via XMLRpc.


## Configuration

Port 25 is exposed by default.
The preconfigured domain name is odoo.test.ch, to change this use environment variable described below.

### Required configuration in Odoo

* In Settings - General Settings : Set the alias domain to be like `POSTFIX_MAIL_NAME` env var.


### Environment variables

#### `POSTFIX_MAIL_NAME`
Set up the domain name the Postfix deamon will answer to.


### DNS
The idea is to add a subdomain (odoo) to the official domain name of the client (ex.: odoo.camptocamp.com)
And route all email with this subdomain to the Postfix instance.
More...


## ToDo

* Move postfix configurtaion from the Dockerfile to the docker-entrypoint.sh

* Add more configuration with env var

* Fix error on email sent by the openerp_mailgate.py script (config)

* Work out the model parameter of openerp_mailgate.py
