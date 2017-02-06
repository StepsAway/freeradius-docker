#!/usr/bin/env bash

################################
#
# install-configs performs pre-launch configuration of the app
#
# Property of StepsAway
#
# Version 0.2
#
################################

# Assumes the configs are properly mounted at /tmp/config
max_attempts=5
timeout=1
attempt=0

while [[ $attempt < $max_attempts ]]; do

  if [ -f /tmp/config/freeradius/clients.conf ]; then
    >&2 printf "Configs found!\n"
    break
  fi

  >&2 printf "Configs not found, trying again in $timeout\n"
  sleep $timeout
  attempt=$(( attempt + 1 ))
  timeout=$(( timeout * 2 ))
done

if [ ! -f /tmp/config/freeradius/clients.conf  ]; then
  >&2 printf "Unable to find container configs...Killing container!\n"
  kill 1
fi

# Copy system files
if [ -f /tmp/config/system/10-syslog.conf ]; then
  cp /tmp/config/system/10-syslog.conf /etc/syslog-ng/conf.d/
  service syslog-ng restart
fi

# Copy freeradius config files
cp -rf /tmp/config/freeradius/* /etc/freeradius/
chown -R freerad:freerad /etc/freeradius
