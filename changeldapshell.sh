#!/bin/bash

args=("$@")
if [ $# -ne 2 ]; then
	echo "usage: $0 <user> <shell>"
	exit 1
fi

TARGETUSER=$1
TARGETSHELL=$2
DC="dc=csua,dc=berkeley,dc=edu"
BASEDN="ou=People,$DC"

if ! grep -Fxq "$TARGETSHELL" /etc/shells; then
	echo "shell $TARGETSHELL not in /etc/shells! Be careful!" 1>&2
fi

cat << EOF | ldapmodify -D "uid=$USER,$BASEDN" -W -x
dn: uid=$TARGETUSER,ou=People,$DC
changetype: modify
replace: loginShell
loginShell: $TARGETSHELL
EOF
