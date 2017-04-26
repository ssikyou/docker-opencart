#!/bin/bash

if [ $# -lt 1 ]
then
    echo "Usage: ./setup_acme.sh </path/to/certs parent dir>"
    exit
fi

echo "install tool and cron job"
curl https://get.acme.sh | sh

echo "issue certs"
if [ "$1" = "web" ]; then
~/.acme.sh/acme.sh --issue --apache -d ${DOMAIN_NAME} -d www.${DOMAIN_NAME}
else
cp -R $1 ~/.acme.sh/
fi

echo "install/copy certs to apache"
~/.acme.sh/acme.sh --installcert -d ${DOMAIN_NAME} \
--certpath      /etc/apache2/certs/${DOMAIN_NAME}/${DOMAIN_NAME}.cer \
--keypath       /etc/apache2/certs/${DOMAIN_NAME}/${DOMAIN_NAME}.key \
--capath        /etc/apache2/certs/${DOMAIN_NAME}/ca.cer \
--fullchainpath /etc/apache2/certs/${DOMAIN_NAME}/fullchain.cer \
--reloadcmd     "service apache2 force-reload"

echo "enable acme auto-update"
~/.acme.sh/acme.sh --upgrade --auto-upgrade
