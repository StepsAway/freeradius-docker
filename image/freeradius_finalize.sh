#!/bin/bash
set -e
source /fr_build/buildconfig
set -x

#rm -rf /etc/freeradius
mkdir -p /etc/service/radius-forwarder
cp /fr_build/services/freeradius/radius-logging.runit /etc/service/radius-forwarder/run
cp /fr_build/my_init/50-install-configs.sh /etc/my_init.d/50-install-configs.sh
touch /var/log/freeradius/radius.log
