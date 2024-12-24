#!/bin/bash

# Load crontab if mounted
if [ -f /etc/cron.d/laravel-crontab ]; then
  chmod 0644 /etc/cron.d/laravel-crontab
  crontab /etc/cron.d/laravel-crontab
fi

# Start cron in the background
service cron start

# Start PHP-FPM
exec "$@"
