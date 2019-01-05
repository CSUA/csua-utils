#!/bin/bash

args=("$@")
if [ $# -ne 1 ]; then
	echo "usage: $0 <cn>"
	exit 1
fi

CN=$1
DC="dc=csua,dc=berkeley,dc=edu"
BASEDN="ou=People,$DC"

FILTER="(cn=$CN)"

ldapsearch -LLL -D "uid=$USER,$BASEDN" -W -x $FILTER
