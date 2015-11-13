#!/bin/sh

if [ $# -gt 1 ]; then
	echo "groupdel: unknown option $1" 1>&2
	exit 1
fi

group="$1"
if [ -z "${group}" ]; then
	echo "groupdel: no group specified" 1>&2
	exit 1
fi

busybox delgroup ${group}
