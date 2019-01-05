#!/bin/bash

args=("$@")
if [ $# -ne 2 ]; then
	echo "usage: $0 <user> <group>"
	exit 1
fi

TARGETUSER=$1
TARGETGROUP=$2
DC="dc=csua,dc=berkeley,dc=edu"
BASEDN="ou=People,$DC"

cat << EOF | ldapmodify -D "uid=$USER,$BASEDN" -W -x
dn: cn=$TARGETGROUP,ou=Group,$DC
changetype: modify
add: memberUid
memberUid: $TARGETUSER
EOF
