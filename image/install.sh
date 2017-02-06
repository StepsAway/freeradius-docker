#!/bin/bash
set -e
source /fr_build/buildconfig
set -x

if [[ "$freeradius30" = 1 ]]; then /fr_build/freeradius30.sh; fi

/fr_build/freeradius_finalize.sh
/fr_build/cleanup.sh
