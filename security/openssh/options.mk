# $NetBSD: options.mk,v 1.29.12.1 2015/07/14 22:03:39 tron Exp $

.include "../../mk/bsd.prefs.mk"

PKG_OPTIONS_VAR=	PKG_OPTIONS.openssh
PKG_SUPPORTED_OPTIONS=	kerberos hpn-patch pam

.include "../../mk/bsd.options.mk"

.if !empty(PKG_OPTIONS:Mkerberos)
.  include "../../mk/krb5.buildlink3.mk"
CONFIGURE_ARGS+=	--with-kerberos5=${KRB5BASE:Q}
.  if ${KRB5_TYPE} == "mit-krb5"
CONFIGURE_ENV+=		ac_cv_search_k_hasafs=no
.  endif
.endif

.if !empty(PKG_OPTIONS:Mhpn-patch)
PATCHFILES=		openssh-6.9p1-hpn-20150709.diff.gz
PATCH_SITES=		ftp://ftp.NetBSD.org/pub/NetBSD/misc/openssh/
PATCH_DIST_STRIP=	-p1
.endif

PLIST_VARS+=	pam

.if !empty(PKG_OPTIONS:Mpam)
.include "../../mk/pam.buildlink3.mk"
CONFIGURE_ARGS+=	--with-pam
MESSAGE_SRC+=		${.CURDIR}/MESSAGE.pam
MESSAGE_SUBST+=		EGDIR=${EGDIR}
.if ${OPSYS} == "Linux"
PLIST.pam=	yes
.endif
.endif
