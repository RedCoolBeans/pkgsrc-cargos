#!/usr/bin/env bash
#
# Copyright (c) 2015 Red Cool Beans
#
# Permission to use, copy, modify, and distribute this software for any
# purpose with or without fee is hereby granted, provided that the above
# copyright notice and this permission notice appear in all copies.
#
# THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
# WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
# MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
# ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
# WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
# ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
# OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
#
# overrides.sh: mount/unmount overrides over PKGSRCDIR

PKGSRCDIR=$(bmake -DBSD_PKG_MK -f /usr/pkg/etc/mk.conf -V PKGSRCDIR) || exit 1
[[ -d ${PKGSRCDIR} ]] || exit 1

OVERRIDES=${PKGSRCDIR}/cargos/overrides
cd ${OVERRIDES} || exit 1

over_mount()
{
	local _ret=0
	for i in $(ls -d */*); do
		grep -q ${PKGSRCDIR}/$i /proc/mounts && continue
		if ! mount -o bind ${OVERRIDES}/$i ${PKGSRCDIR}/$i; then
			echo "===> ERROR mounting ${PKGSRCDIR}/$i"
			_ret=1
		fi
	done
	return ${_ret}
}

over_umount()
{
	local _ret=0
	for i in $(ls -d */*); do
		grep -q ${PKGSRCDIR}/$i /proc/mounts || continue
		if ! umount ${PKGSRCDIR}/$i; then
			echo "===> ERROR unmounting ${PKGSRCDIR}/$i"
			_ret=1
		fi
	done
	return ${_ret}
}

case $1 in
	mount)		over_mount ;;
	umount)		over_umount ;;
	*)		echo "usage: ${0##*/} mount|umount"; exit 1 ;;
esac
