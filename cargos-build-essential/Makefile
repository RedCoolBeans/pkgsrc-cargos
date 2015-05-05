# $NetBSD$

DISTNAME=		cargos-build-essential-2015.8
CATEGORIES=		devel
MASTER_SITES=		# empty
DISTFILES=		# empty

MAINTAINER=		pkgsrc@cargos.io
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

CONF_FILES +=		${EGDIR}/etc/ld.so.conf.d/pkgsrc.conf /etc/ld.so.conf.d/pkgsrc.conf

do-build:
	${SED} -e "s,@LOCALBASE@,${LOCALBASE},g" \
		-e "s,@EGDIR@,${EGDIR},g" \
		-e "s,@PKGNAME@,${PKGNAME},g" \
		${FILESDIR}/etc/ld.so.conf.d/pkgsrc.conf \
		>${WRKDIR}/pkgsrc.conf

do-install:
	${INSTALL_DATA} ${WRKDIR}/pkgsrc.conf \
		${DESTDIR}${EGDIR}/etc/ld.so.conf.d/pkgsrc.conf

.include "../../mk/bsd.pkg.mk"
