# $NetBSD$

DISTNAME=		cargos-build-essential-2015.7
CATEGORIES=		devel
MASTER_SITES=		# empty
DISTFILES=		# empty

MAINTAINER=		antoine@redcoolbeans.com
HOMEPAGE=		http://cargos.io/
COMMENT=		CargOS build environment
LICENSE=		isc

NO_CONFIGURE=		yes

# pkgsrc
DEPENDS +=		bmake-[0-9]*:../../devel/bmake
DEPENDS +=		bootstrap-mk-files-[0-9]*:../../pkgtools/bootstrap-mk-files
DEPENDS +=		cvs-[0-9]*:../../devel/scmcvs
DEPENDS +=		digest-[0-9]*:../../pkgtools/digest
DEPENDS +=		file-[0-9]*:../../sysutils/file
DEPENDS +=		gcc47>=4.7:../../lang/gcc47
DEPENDS +=		gnupg-[0-9]*:../../security/gnupg
DEPENDS +=		nbpatch-[0-9]*:../../devel/nbpatch
DEPENDS +=		wget-[0-9]*:../../net/wget

# cargos
DEPENDS +=		cargos-release-[0-9]*:../../cargos/cargos-release
DEPENDS +=		git-base-[0-9]*:../../devel/git-base

WRKSRC=			${WRKDIR}

EG=			share/examples/cargos-build-essential
EGDIR=			${PREFIX}/${EG}

INSTALLATION_DIRS +=	${EG}/etc/ld.so.conf.d ${EG}/etc/profile.d
INSTALLATION_DIRS +=	${EG}${PKG_SYSCONFDIR}

CONF_FILES +=		${EGDIR}${PKG_SYSCONFDIR}/mk.conf ${PKG_SYSCONFDIR}/mk.conf
CONF_FILES +=		${EGDIR}/etc/ld.so.conf.d/pkgsrc.conf /etc/ld.so.conf.d/pkgsrc.conf
CONF_FILES +=		${EGDIR}/etc/profile.d/pkgsrc.sh /etc/profile.d/pkgsrc.sh

do-build:
	${SED} -e "s,@LOCALBASE@,${LOCALBASE},g" \
		-e "s,@EGDIR@,${EGDIR},g" \
		-e "s,@PKGNAME@,${PKGNAME},g" \
		${FILESDIR}/etc/ld.so.conf.d/pkgsrc.conf \
		>${WRKDIR}/pkgsrc.conf
	${SED} -e "s,@PREFIX@,${PREFIX},g" \
		-e "s,@EGDIR@,${EGDIR},g" \
		-e "s,@PKGNAME@,${PKGNAME},g" \
		${FILESDIR}/usr/pkg/etc/mk.conf \
		>${WRKDIR}/mk.conf

do-install:
	${INSTALL_DATA} ${WRKDIR}/mk.conf \
		${DESTDIR}${EGDIR}${PKG_SYSCONFDIR}/mk.conf
	${INSTALL_DATA} ${WRKDIR}/pkgsrc.conf \
		${DESTDIR}${EGDIR}/etc/ld.so.conf.d/pkgsrc.conf
	${INSTALL_DATA} ${FILESDIR}/etc/profile.d/pkgsrc.sh \
		${DESTDIR}${EGDIR}/etc/profile.d/pkgsrc.sh

.include "../../mk/bsd.pkg.mk"
