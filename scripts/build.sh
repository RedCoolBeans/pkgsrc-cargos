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
# build.sh: build CargOS packages set

# XXX candidates?
# net/nsd
# net/unbound
# sysutils/libvirt
# sysutils/virtinst

eval $(/bin/grep ^VERIFIED_INSTALLATION /usr/pkg/etc/pkg_install.conf | \
	/usr/bin/tr -d '[[:space:]]')
if [[ ${VERIFIED_INSTALLATION} != "never" ]]; then
	/bin/echo
	/bin/echo "===> ERROR, for bulk builds, VERIFIED_INSTALLATION must be set to \"never\" in:"
	/bin/echo "     /usr/pkg/etc/pkg_install.conf"
	/bin/echo
	exit 1
fi

### pkg build list #####################################################
# bootstrap (REQ)
PKGS="
pkgtools/pkg_install
pkgtools/bootstrap-mk-files
devel/bmake
lang/gcc47-libs
"

# CargOS (REQ)
PKGS="${PKGS}
cargos/cargos-build-essential
cargos/cargos-release
"

# core tools (OPT)
PKGS="${PKGS}
archivers/bzip2
archivers/gtar
archivers/gzip
archivers/xz
devel/diffutils
devel/patch
lang/gawk
sysutils/coreutils
sysutils/findutils
textproc/gsed
"

# add-ons: base (OPT)
PKGS="${PKGS}
editors/vim
misc/tmux
net/openvpn
net/rsync
net/tcpdump
security/sudo
www/links
"

# add-ons: hardware (OPT)
PKGS="${PKGS}
sysutils/smartmontools
sysutils/ups-nut-snmp
sysutils/ups-nut-usb
"
# add-ons: devops (OPT)
PKGS="${PKGS}
sysutils/ansible
sysutils/puppet
sysutils/salt
"

# add-ons: misc (OPT)
PKGS="${PKGS}
databases/mysql55-server
databases/openldap
databases/p5-DBD-mysql
databases/postgresql93-server
devel/git-svn
devel/subversion
editors/mg
lang/lua52
meta-pkgs/php54-extensions
net/bind99
net/isc-dhcpd4
net/jwhois
security/clamav
sysutils/monit
www/apache22
www/nginx
www/varnish
"
########################################################################

pkg_add -u cargos-build-essential-* # don't match the "cargos-build-essential-" directory
PACKAGES=$(bmake -DBSD_PKG_MK -f /usr/pkg/etc/mk.conf -V PACKAGES) || exit 1
PKGSRCDIR=$(bmake -DBSD_PKG_MK -f /usr/pkg/etc/mk.conf -V PKGSRCDIR) || exit 1
WRKOBJDIR=$(bmake -DBSD_PKG_MK -f /usr/pkg/etc/mk.conf -V WRKOBJDIR) || exit 1
[[ ${PACKAGES} && ${PKGSRCDIR} && ${WRKOBJDIR} ]] || exit 1

# preserved packages
pkg_delete -Nff cargos-release pkg_install || exit 1
# build bootstrap
pkg_delete -Nf cargos-build-essential bmake bootstrap-mk-files gcc47 || exit 1
# gcc47 dependencies
pkg_delete -Nf gmp mpcomplex mpfr || exit 1
# fetch distfiles
pkg_delete -Nf libidn openssl wget || exit 1
# sign packages
pkg_delete -Nf bzip2 gnupg || exit 1
# needed by libtool(1)
pkg_delete -Nf file || exit 1

pkg_info -a | /usr/bin/cut -d ' ' -f1 | while read i ; do pkg_delete -kr $i ; done
pkg_admin rebuild-tree || exit 1

# we need the overrides
/bin/bash ${PKGSRCDIR}/cargos/scripts/overrides.sh mount || exit 1

/bin/rm -rf ${PACKAGES}/*
/bin/rm -rf ${WRKOBJDIR}/*

for p in ${PKGS}; do
	/usr/bin/clear
	/bin/echo "========================================================================"
	/bin/echo "===> ${0##*/} BUILDING $p"
	/bin/echo "========================================================================"
	/bin/echo
	cd ${PKGSRCDIR}/$p || exit 1
	bmake MAKE_JOBS=$(getconf _NPROCESSORS_ONLN) \
		ALLOW_VULNERABLE_PACKAGES=yes \
		SKIP_LICENSE_CHECK=yes package-install || ERR="$p ${ERR}"
done

pkg_admin rebuild-tree || exit 1
/bin/bash ${PKGSRCDIR}/cargos/scripts/overrides.sh umount

/bin/echo
/bin/echo "------------------------------------------------------------------------"
/bin/echo "===> DONE! (${0##*/})"
if [[ ${ERR} ]]; then
	/bin/echo "===> ERROR, these packages fail to build:"
	for p in ${ERR}; do
		/bin/echo "     $p"
	done
	/bin/echo
	/bin/echo "     The system maybe be in an unconsistent state, run:"
	/bin/echo "     pkg_add -U cargos-release && pkg_admin rebuild-tree"
	exit 1
fi
/bin/echo "------------------------------------------------------------------------"
/bin/echo
