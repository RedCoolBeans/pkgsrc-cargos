#!/bin/sh

if [ $# -gt 1 ]; then
	echo "userdel: unknown option $1" 1>&2
	exit 1
fi

user="$1"
if [ -z "${user}" ]; then
	echo "userdel: no user specified" 1>&2
	exit 1
fi

busybox deluser ${user}
