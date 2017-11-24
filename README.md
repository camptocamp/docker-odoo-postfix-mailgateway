# docker-odoo-postfix-mailgateway

A Docker image that routes emails to various Odoo instances according to the configuration it is given.

This image uses Postfix as a MTA and the [`openerp_mailgate.py`](https://github.com/odoo/odoo/blob/11.0/addons/mail/static/scripts/openerp_mailgate.py) script to push the emails to Odoo.

It supports multiple Odoo instances in parallel, therefore multiple domain names.


## Configuration

Port 25 is exposed by default.

### Environment variables

`POSTFIX_HOSTNAME` : The `myhostname` Postfix parameter.

`CLIENT_INSTANCE`   : A JSON structure containing the description of each Odoo instance whose emails need to be routed to.
```
    CLIENT_INSTANCE=[
        {"name":"test",
         "domain":"odoo.test.ch",
         "odoo_host":"odoo",
         "odoo_db":"odoodb",
         "odoo_user_id":"1",
         "odoo_user_pwd":"test",
         "odoo_model":"crm.lead"
        },
        {"name":"c2c",
         "domain":"odoo.camptocamp.com",
         "odoo_host":"odoo8",
         "odoo_db":"odoodb",
         "odoo_user_id":"2",
         "odoo_user_pwd":"admin",
         "odoo_model":"crm.lead"
        }
    ]
```
Note: Surrounding the whole environment variable declaration with quotes allow for multiple line.

And the description of the fields of the previous JSON structure
* `name`              : Name of the client
* `domain`            : The domain name of the client email address
* `odoo_db_name`      : Name of Odoo database.
* `odoo_user_id`      : Id of the Odoo user to run mailgate.
* `odoo_user_pwd`     : Password of the Odoo user.
* `odoo_model`        : Parent model (target), it is optional.


### Required configuration in Odoo

* In Settings - General Settings : Set the alias domain, which is the domain in the `CLIENT_INSTANCE` structure as `domain`.

* In Settings - Email - Aliases  : Set how an email address will be handled, if there is no aliases for a specific address it will be transform into a Sale Lead.


### DNS
The idea is to add a subdomain (odoo) to the official domain name of the client (ex.: odoo.camptocamp.com)
And route all email with this subdomain to the Postfix MTA.


## ToDo
* Test with multiple domain name and Odoo instance.
* Improve Postfix config and think about security.
* How would this be included in Rancher ?
