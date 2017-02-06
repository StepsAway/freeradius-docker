#!/bin/bash
set -o pipefail

function ok()
{
	echo "  OK"
}

function fail()
{
	echo "  FAIL"
	exit 1
}

echo "Checking freeradius is installed and has the proper version..."
freeradius=$(freeradius -v | awk 'NR==1{ print $4 }' | cut -d ',' -f 1)
if [[ $freeradius == $1 ]]; then
	ok
else
	echo "Wrong version of freeradius installed!"
	fail
fi
