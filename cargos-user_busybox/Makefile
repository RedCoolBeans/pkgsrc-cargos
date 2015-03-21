# $NetBSD$

PKGNAME=		cargos-user-busybox-20150305
CATEGORIES=		sysutils
MASTER_SITES=		# empty
DISTFILES=		# empty
PKGREVISION=		1

MAINTAINER=		pkgsrc@cargos.io
HOMEPAGE=		http://cargos.io/
COMMENT=		Limited NetBSD-compatible useradd/groupadd commands
LICENSE=		isc

INSTALLATION_DIRS=	libexec share/examples/cargos-user-busybox
NO_CONFIGURE=		yes
WRKSRC=			${WRKDIR}

EG=			share/examples/cargos-user-busybox
EGDIR=			${PREFIX}/${EG}

INSTALLATION_DIRS=	libexec ${EG}

CONF_FILES +=		${EGDIR}/login.defs /etc/login.defs

do-build:
	${SED} -e "s,@PREFIX@,${PREFIX},g" \
		${FILESDIR}/useradd.sh >${WRKDIR}/useradd.sh

do-install:
	${INSTALL_SCRIPT} ${WRKDIR}/useradd.sh ${DESTDIR}${PREFIX}/libexec/useradd
#	${INSTALL_SCRIPT} ${FILESDIR}/userdel.sh ${DESTDIR}${PREFIX}/libexec/userdel
	${INSTALL_SCRIPT} ${FILESDIR}/groupadd.sh ${DESTDIR}${PREFIX}/libexec/groupadd
#	${INSTALL_SCRIPT} ${FILESDIR}/groupdel.sh ${DESTDIR}${PREFIX}/libexec/groupdel
	${INSTALL_SCRIPT} ${FILESDIR}/login.defs ${DESTDIR}${EGDIR}/login.defs

.include "../../mk/bsd.pkg.mk"
