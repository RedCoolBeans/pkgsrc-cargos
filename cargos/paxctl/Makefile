# $NetBSD$

DISTNAME=	paxctl-0.9
CATEGORIES=	security
MASTER_SITES=	https://pax.grsecurity.net/

MAINTAINER=	robert@redcoolbeans.com	
HOMEPAGE=	http://pax.grsecurity.net/
COMMENT=	PaX control program
LICENSE=	gnu-gpl-v2

USE_TOOLS+=		gmake

INSTALLATION_DIRS=	sbin ${PKGMANDIR}/man1

do-install:
	${INSTALL_PROGRAM} ${WRKSRC}/paxctl ${DESTDIR}${PREFIX}/sbin
	${INSTALL_MAN} ${WRKSRC}/paxctl.1 ${DESTDIR}${PREFIX}/${PKGMANDIR}/man1

.include "../../mk/bsd.pkg.mk"
