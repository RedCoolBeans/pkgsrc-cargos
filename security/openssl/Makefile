# $NetBSD: Makefile,v 1.12 2015/04/12 00:10:27 krytarowski Exp $

CONFLICTS+=	openssl-[0-9]*
SUPERSEDES+=	openssl-[0-9]*

DISTNAME=	libressl-2.2.6
CATEGORIES=	security
MASTER_SITES=	${MASTER_SITE_OPENBSD:=LibreSSL/}

MAINTAINER=	pkgsrc@cargos.io
HOMEPAGE=	http://www.libressl.org/
COMMENT=	Secure Sockets Layer and cryptography libraries and tools
LICENSE=	openssl

GNU_CONFIGURE=	yes
USE_LIBTOOL=	yes
USE_TOOLS+=	pkg-config

PKGCONFIG_OVERRIDE+=	libcrypto.pc.in
PKGCONFIG_OVERRIDE+=	libssl.pc.in
PKGCONFIG_OVERRIDE+=	openssl.pc.in

PKG_SYSCONFSUBDIR=	openssl
CONFIGURE_ARGS+=	--with-openssldir=${PKG_SYSCONFDIR}

OWN_DIRS=	${PKG_SYSCONFDIR}/certs ${PKG_SYSCONFDIR}/private /etc/ssl/certs

INSTALLATION_DIRS+=	share/examples/openssl

EGDIR=		${PREFIX}/share/examples/libressl
CONF_FILES+=	${EGDIR}/cert.pem ${PKG_SYSCONFDIR}/cert.pem
CONF_FILES+=	${EGDIR}/openssl.cnf ${PKG_SYSCONFDIR}/openssl.cnf
CONF_FILES+=	${EGDIR}/x509v3.cnf ${PKG_SYSCONFDIR}/x509v3.cnf

TEST_TARGET=	check

post-install:
	mv ${DESTDIR}${PKG_SYSCONFDIR} ${DESTDIR}${EGDIR}

.include "../../mk/bsd.pkg.mk"
