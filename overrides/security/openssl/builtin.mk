# $NetBSD$

BUILTIN_PKG:=	openssl
.include "../../mk/buildlink3/bsd.builtin.mk"

IS_BUILTIN.openssl=	no
USE_BUILTIN.openssl=	no

SSLDIR=		${PKG_SYSCONFBASEDIR}/openssl
SSLCERTS=	${SSLDIR}/certs
SSLKEYS=	${SSLDIR}/private

BUILD_DEFS+=	SSLDIR SSLCERTS SSLKEYS
