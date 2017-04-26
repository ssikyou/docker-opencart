#!/bin/bash

if [ $# -lt 1 ]
then
    echo "Usage: ./clean.sh <DOMAIN_NAME>"
    exit
fi

DOMAIN_NAME=$1

echo "Cleaning website codes, mysql dbs and httpd logs..."
rm -rf webroot/$DOMAIN_NAME
rm -rf mysql/data
rm -rf apache-php/logs
echo "Done!"
