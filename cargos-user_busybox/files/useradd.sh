#!/bin/sh

while getopts 'g:u:rs:c:d:' o; do
	case $o in
	c)	comment="${OPTARG}";;
	d)	homedir="${OPTARG}";;
	g)	group="${OPTARG}";;
	r)	sysusr="yes";;
	s)	shell="${OPTARG}";;
	u)	uid="${OPTARG}";;
	*)	echo "useradd: unknown option $1" 1>&2; exit 1; ;;
	esac
done
shift $(($OPTIND - 1))

user=$1
if [ -z "${user}" ]; then
	echo "useradd: no user specified" 1>&2
	exit 1
fi

if [ "${comment}" ]; then args="${args} -g \"${comment}\""; fi
if [ "${group}" ]; then args="${args} -G ${group}"; fi
if [ "${sysusr}" ]; then args="${args} -S"; fi
if [ "${shell}" ]; then args="${args} -s ${shell}"; fi
if [ "${uid}" ]; then args="${args} -u ${uid}"; fi

if [ "${homedir}" ]; then
	args="${args} -h ${homedir}"
else
	args="${args} -H -h @PREFIX@/var/empty"
fi

# busybox adduser cannot create a full hierarchy
if [ "${homedir}" ]; then
	mkdir -p $(dirname ${homedir})
fi

eval "busybox adduser -D ${args} -s ${shell:=/bin/false} ${user}"
ret=$?

# remove setgid on homedir and set owner to root:root for system users
if [ "${sysusr}" -a -d "${homedir}" ]; then
	/bin/chmod -s ${homedir}
	/bin/chown 0:0 ${homedir}
fi

exit ${ret}
