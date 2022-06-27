#!/bin/bash

# update sources hourly.
mv ./update-sources.sh /etc/cron.hourly/update-sources && \
  chmod +x /etc/cron.hourly/update-sources.sh

# to do: DNS log analysis and ssh hourly for sending alerts.
# not very reasonable perhaps every 15 seconds works best for real time
# but beats the purpose of demonstration.
