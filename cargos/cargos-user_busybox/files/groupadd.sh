#!/bin/sh

group="$1"

while getopts 'g:r' o; do
	case $o in
	g)	gid="${OPTARG}";;
	r)	sysgrp="yes";;
	*)	echo "groupadd: unknown option $1" 1>&2; exit 1; ;;
	esac
done
shift $(($OPTIND - 1))

group=$1
if [ -z "${group}" ]; then
	echo "groupadd: no group specified" 1>&2
	exit 1
fi

if [ "${gid}" ]; then args="-g ${gid}"; fi
if [ "${sysgrp}" ]; then args="-S"; fi

busybox addgroup ${args} ${group}
