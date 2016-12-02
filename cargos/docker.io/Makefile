# $NetBSD$

ONLY_FOR_PLATFORM=	Linux-*-x86_64

V=			1.12.1
PKGREVISION=		1
DISTNAME=		docker-${V}
PKGNAME=		docker.io-${V}
CATEGORIES=		sysutils
MASTER_SITES=		https://get.docker.com/builds/Linux/x86_64/
EXTRACT_SUFX=		.tgz

MAINTAINER=		pkgsrc@cargos.io
HOMEPAGE=		http://www.docker.com/
COMMENT=		Pack, ship and run any application as a lightweight container
LICENSE=		apache-2.0

INSTALLATION_DIRS=	bin
NO_BUILD=		yes
PKG_GROUPS=		docker
RCD_SCRIPTS=		dockerd

DEPENDS+=		mozilla-rootcerts-[0-9]*:../../security/mozilla-rootcerts

DOCKER_BINS =		docker dockerd docker-containerd docker-containerd-ctr \
			docker-containerd-shim docker-runc docker-proxy

# unconfuse pkgsrc otherwise the rcd script isn't installed
post-extract:
	mv ${WRKDIR}/docker ${WRKDIR}/docker-$V

do-install:
.for d in ${DOCKER_BINS}
	${INSTALL_SCRIPT} ${WRKSRC}/$d ${DESTDIR}${PREFIX}/bin/
.endfor

.include "../../mk/bsd.pkg.mk"
