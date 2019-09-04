#!/bin/bash
# searches through all .forward files for the regexp given in QUERY.
# must be run on tap to work.
if [ $# -ne 1 ]; then
	echo "usage: $0 <query>"
	exit 1
fi
QUERY=$1

sudo find /nfs/homes/ -maxdepth 2 -name .forward -type f -print0 \
	| sudo xargs -r -0 \
	grep -l $QUERY \
	| cut -d '/' -f 4
