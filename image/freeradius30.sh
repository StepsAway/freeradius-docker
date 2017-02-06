#!/bin/bash
set -e
source /fr_build/buildconfig
source /fr_build/freeradius_install
set -x

FREERADIUS_MAJOR=3.0
FREERADIUS_VERSION=3.0.12-ppa1~trusty

freeradius_install
