# $NetBSD$

ONLY_FOR_PLATFORM=	Linux-*-x86_64

V=			0.3.1
DISTNAME=		docker-machine_linux-amd64
PKGNAME=		docker-machine-${V}
CATEGORIES=		sysutils
MASTER_SITES=		https://github.com/docker/machine/releases/download/v${V}/
EXTRACT_SUFX=		# empty

MAINTAINER=		pkgsrc@cargos.io
HOMEPAGE=		https://docs.docker.com/machine/
COMMENT=		Create, use and manage Docker hosts
LICENSE=		apache-2.0

INSTALLATION_DIRS=	bin
NO_BUILD=		yes
WRKSRC=			${WRKDIR}/docker-machine-${V}

DEPENDS+=		docker.io-[0-9]*:../../cargos/docker.io

do-install:
	${INSTALL_SCRIPT} ${WRKDIR}/${DISTNAME} \
		${DESTDIR}${PREFIX}/bin/docker-machine

.include "../../mk/bsd.pkg.mk"
