# $NetBSD$

ONLY_FOR_PLATFORM=	Linux-*-x86_64

V=			1.4.2
DISTNAME=		docker-compose-Linux-x86_64
PKGNAME=		docker-compose-${V}
CATEGORIES=		sysutils
MASTER_SITES=		https://github.com/docker/compose/releases/download/${V}/
EXTRACT_SUFX=		# empty

MAINTAINER=		pkgsrc@cargos.io
HOMEPAGE=		http://docs.docker.com/compose/
COMMENT=		Define and run complex applications using Docker
LICENSE=		apache-2.0

INSTALLATION_DIRS=	bin libexec
NO_BUILD=		yes
WRKSRC=			${WRKDIR}/docker-compose-${V}

DEPENDS+=		docker.io-[0-9]*:../../cargos/docker.io

do-install:
	${INSTALL_SCRIPT} ${WRKDIR}/${DISTNAME} \
		${DESTDIR}${PREFIX}/bin/docker-compose

.include "../../mk/bsd.pkg.mk"
