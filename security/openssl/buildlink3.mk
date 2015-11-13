# $NetBSD: buildlink3.mk,v 1.49 2014/02/12 23:23:17 tron Exp $

BUILDLINK_TREE+=	openssl

.if !defined(OPENSSL_BUILDLINK3_MK)
OPENSSL_BUILDLINK3_MK:=

.  include "../../mk/bsd.fast.prefs.mk"

BUILDLINK_API_DEPENDS.openssl=	libressl>=2.2.0
BUILDLINK_ABI_DEPENDS.openssl=	libressl>=2.2.0
BUILDLINK_PKGSRCDIR.openssl?=	../../security/openssl

SSLBASE=	${BUILDLINK_PREFIX.openssl}
BUILD_DEFS+=	SSLBASE

.endif # OPENSSL_BUILDLINK3_MK

BUILDLINK_TREE+=	-openssl
