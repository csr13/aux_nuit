#!/bin/bash
# Django commands to dump db and other stuff

source ./settings.env

SETTINGS=$SETTINGS_MODULE

python ../api/manage.py dumpdata --natural-foreign --natural-primary -e contenttypes -e auth.Permission -e sessions --indent 4 --format json -o global-fixtures.json --settings=$SETTINGS
