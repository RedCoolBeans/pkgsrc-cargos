# $NetBSD: options.mk,v 1.4 2013/07/04 16:19:41 wiz Exp $

PKG_OPTIONS_VAR=	PKG_OPTIONS.gtexinfo
PKG_SUPPORTED_OPTIONS=	nls
PKG_SUGGESTED_OPTIONS=	# blank
.if ${OPSYS} == "NetBSD"
PKG_SUGGESTED_OPTIONS+=	nls
.endif

PKG_OPTIONS_LEGACY_VARS=	TEXINFO_LOCALE

.include "../../mk/bsd.options.mk"

.if !empty(PKG_OPTIONS:Mnls)
USE_PKGLOCALEDIR=	yes
PLIST_SRC+=		${PKGDIR}/PLIST.locale
.  include "../../devel/gettext-lib/buildlink3.mk"
.else
CONFIGURE_ARGS+=	--disable-nls
.endif
