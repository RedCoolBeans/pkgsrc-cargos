# $NetBSD: Makefile,v 1.38 2016/08/13 17:34:41 taca Exp $

MODNAME=		gd
PKGREVISION=		1
CATEGORIES+=		graphics
COMMENT=		PHP extension for GD graphics library

CONFLICTS=	php-gd-[0-9]*

# XXX we use bundled GD so that extension is usable also by non-threaded
# PHP, such as CLI/CGI version or ap-php on Apache 1.x.

CONFIGURE_ARGS+=	--with-${MODNAME}=${BUILDLINK_DIR:Q}
CONFIGURE_ARGS+=	--with-jpeg-dir=${BUILDLINK_DIR:Q}
CONFIGURE_ARGS+=	--with-png-dir=${BUILDLINK_DIR:Q}
CONFIGURE_ARGS+=	--with-zlib-dir=${BUILDLINK_DIR:Q}
CONFIGURE_ARGS+=	--with-freetype-dir=${BUILDLINK_DIR:Q}
CONFIGURE_ARGS+=	--enable-${MODNAME}-native-ttf
CONFIGURE_ARGS+=	--enable-${MODNAME}-jis-conv
CONFIGURE_ARGS+=	--without-t1lib

USE_PHP_EXT_PATCHES=	yes

.include "options.mk"

.include "../../crane/gd/buildlink3.mk"
.include "../../crane/php/ext.mk"
.include "../../mk/bsd.pkg.mk"
