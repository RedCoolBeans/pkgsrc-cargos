# $NetBSD$

VERSION=		2015.7
DISTNAME=		cargos-release-${VERSION}
CATEGORIES=		sysutils
MASTER_SITES=		# empty
DISTFILES=		# empty
PKGREVISION=		13

MAINTAINER=		pkgsrc@cargos.io
HOMEPAGE=		http://cargos.io/
COMMENT=		CargOS base system
LICENSE=		isc

NO_CONFIGURE=		yes
PKG_PRESERVE=		yes

DEPENDS +=		docker.io-[0-9]*:../../cargos/docker.io
DEPENDS +=		mdocml-[0-9]*:../../textproc/mdocml
DEPENDS +=		openssh-[0-9]*:../../security/openssh
DEPENDS +=		mozilla-rootcerts-[0-9]*:../../security/mozilla-rootcerts
DEPENDS +=		pkgin-[0-9]*:../../pkgtools/pkgin

EG=			share/examples/cargos-release
EGDIR=			${PREFIX}/${EG}

WRKSRC=			${WRKDIR}

.for d in /etc/acpi/PWRB /etc/acpi/PWRF /etc/ld.so.conf.d /etc/profile.d \
          /etc/rc.conf.d /usr/pkg/etc/gnupg
INSTALLATION_DIRS +=	${EG}${d}
MAKE_DIRS +=		${d}
.endfor

F600S +=		/etc/cron/crontabs/root

F644S +=		/etc/ld.so.conf
F644S +=		/etc/ntp.conf
F644S +=		/etc/os-release
F644S +=		/etc/profile
F644S +=		/etc/profile.d/pkg.sh
F644S +=		/etc/profile.d/pkgsrc.sh
F644S +=		/etc/rc.conf.d/docker
F644S +=		/etc/rc.conf.d/sshd

F644S +=		/usr/pkg/etc/gnupg/pkgsrc.gpg
F644S +=		/usr/pkg/etc/mk.conf
F644S +=		/usr/pkg/etc/pkg_install.conf

F755S +=		/etc/acpi/PWRB/00000080

.for f in ${F600S}
CONF_FILES_PERMS +=	${EGDIR}${f} ${f} ${ROOT_USER} ${ROOT_GROUP} 0600
.endfor

.for f in ${F644S}
CONF_FILES +=		${EGDIR}${f} ${f}
.endfor

.for f in ${F755S}
CONF_FILES_PERMS +=	${EGDIR}${f} ${f} ${ROOT_USER} ${ROOT_GROUP} 0755
.endfor

INSTALLATION_DIRS +=	${EG}/etc/cron/crontabs ${VARBASE}
MAKE_DIRS_PERMS +=	/etc/cron/crontabs ${ROOT_USER} ${ROOT_GROUP} 0750
CONF_FILES_PERMS +=	${EGDIR}/etc/acpi/PWRB/00000080 /etc/acpi/PWRF/00000080 \
				${ROOT_USER} ${ROOT_GROUP} 0755

do-build:
.for d in ${MAKE_DIRS} /etc/cron/crontabs
	${MKDIR} ${WRKDIR}${d}
.endfor
.for f in ${F600S} ${F644S} ${F755S}
	${SED} -e "s,@LOCALBASE@,${LOCALBASE},g" \
		-e "s,@MACHINE@,$$(uname -m),g" \
		-e "s,@EGDIR@,${EGDIR},g" \
		-e "s,@PKGNAME@,${PKGNAME},g" \
		-e "s,@PKG_SYSCONFDIR@,${PKG_SYSCONFDIR},g" \
		-e "s,@PREFIX@,${PREFIX},g" \
		-e "s,@VERSION@,${VERSION},g" \
		 ${FILESDIR}/${f} >${WRKDIR}${f}
.endfor

do-install:
.for f in ${F600S} ${F644S} ${F755S}
	${INSTALL_DATA} ${WRKDIR}${f} ${DESTDIR}${EGDIR}${f}
.endfor
	ln -sf /tmp ${DESTDIR}${VARBASE}/run
	ln -sf /tmp ${DESTDIR}${VARBASE}/tmp

.include "../../mk/bsd.pkg.mk"
