#!/bin/bash

# update sources hourly.
mv ./update-sources.sh /etc/cron.hourly/update-sources && \
  chmod +x /etc/cron.hourly/update-sources
