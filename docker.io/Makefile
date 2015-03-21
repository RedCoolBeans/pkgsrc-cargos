# $NetBSD$

ONLY_FOR_PLATFORM=	Linux-*-x86_64

V=			1.5.0
DISTNAME=		docker-${V}
PKGNAME=		docker.io-${V}
CATEGORIES=		sysutils
MASTER_SITES=		https://get.docker.com/builds/Linux/x86_64/
EXTRACT_SUFX=		# empty
PKGREVISION=		2

MAINTAINER=		pkgsrc@cargos.io
HOMEPAGE=		http://www.docker.com/
COMMENT=		Pack, ship and run any application as a lightweight container
LICENSE=		apache-2.0

INSTALLATION_DIRS=	bin
NO_BUILD=		yes
PKG_GROUPS=		docker
RCD_SCRIPTS=		docker
WRKSRC=			${WRKDIR}/docker-1.5.0

DEPENDS=		mozilla-rootcerts-[0-9]*:../../security/mozilla-rootcerts

do-install:
	${INSTALL_PROGRAM} ${WRKDIR}/${DISTNAME} \
		${DESTDIR}${PREFIX}/bin/docker

.include "../../mk/bsd.pkg.mk"
