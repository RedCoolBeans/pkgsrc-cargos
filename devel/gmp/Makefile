# $NetBSD: Makefile,v 1.77 2015/03/30 18:48:08 gdt Exp $

DISTNAME=	gmp-6.0.0a
CATEGORIES=	devel math
MASTER_SITES=	https://gmplib.org/download/gmp/ \
		${MASTER_SITE_GNU:=gmp/}
# Use .tar.bz2 distfile so that no extra dependency on archivers/xz
# is needed when building lang/gcc* with option gcc-inplace-math.
EXTRACT_SUFX=	.tar.bz2

MAINTAINER=	pkgsrc-users@NetBSD.org
HOMEPAGE=	http://gmplib.org/
COMMENT=	Library for arbitrary precision arithmetic
LICENSE=	gnu-lgpl-v3 OR gnu-gpl-v2

INFO_FILES=		yes
USE_LANGUAGES=		c c++ c99
USE_LIBTOOL=		yes
USE_TOOLS+=		gm4 autoconf makeinfo
GNU_CONFIGURE=		yes
CONFIGURE_ARGS+=	--without-readline

WRKSRC=		${WRKDIR}/${DISTNAME:S/a$//}

TEST_TARGET=		check

PLIST_VARS+=		cxx

.include "../../mk/bsd.prefs.mk"

.if !empty(USE_CROSS_COMPILE:M[yY][eE][sS])
CONFIGURE_ENV+=		CC_FOR_BUILD=${NATIVE_CC:Q}
.endif

.if empty(PKGSRC_COMPILER:Msunpro)
CONFIGURE_ARGS+=	--enable-cxx
PLIST.cxx=		yes
.endif

.if !empty(MACHINE_PLATFORM:MIRIX-5*) && !empty(ABI)
ABI=			o32
.endif

.if ${MACHINE_ARCH} == "arm" || ${MACHINE_ARCH} == "arm32"
# The configure script thinks gcc 2.95 for ARM is too buggy to use.
GCC_REQD+=		3.0
.endif

.if ${MACHINE_ARCH} == "i386"
# XXX SunOS should work, but currently bombs in mpn/fat.c
.  if ${OPSYS} == "Darwin" || ${OPSYS} == "SunOS" || !empty(PKGSRC_COMPILER:Msunpro)
# don't use x86 assembly (it doesn't build)
CONFIGURE_ENV+=		MPN_PATH="generic"
.  else
PKG_OPTIONS_VAR=	PKG_OPTIONS.gmp
PKG_SUPPORTED_OPTIONS=	gmp-fat mmx simd
PKG_SUGGESTED_OPTIONS=	gmp-fat
.    include "../../mk/bsd.options.mk"
###
### Support for a "fat" binary on i386, with CPU autodetection.
### XXX this option should be provided for amd64 too!
###
### XXX	Currently, the 'mmx' and 'simd' options imply the same thing,
###	as cpu detection is done at runtime.  Is there a more elegant
###	way to handle this?
###
.    if empty(PKG_OPTIONS:Mgmp-fat) &&	\
        (!empty(PKG_OPTIONS:Mmmx) || !empty(PKG_OPTIONS:Msimd))
PKG_OPTIONS+=	gmp-fat
.    endif
.    if !empty(PKG_OPTIONS:Mgmp-fat)
CONFIGURE_ARGS+=	--enable-fat
.    endif
.  endif
.endif

pre-configure:
	cd ${WRKSRC} && type autoconf && autoconf

.include "../../mk/bsd.pkg.mk"
