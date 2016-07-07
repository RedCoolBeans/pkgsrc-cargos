# $NetBSD: Makefile,v 1.5 2015/07/26 18:06:45 nros Exp $

DISTNAME=	libgit2-0.24.0
PKGNAME=	${DISTNAME:S/-/-static-/}
CATEGORIES=	devel
MASTER_SITES=	${MASTER_SITE_GITHUB:=libgit2/}

MAINTAINER=	pkgsrc-users@NetBSD.org
HOMEPAGE=	http://libgit2.github.com/
COMMENT=	Portable, pure C implementation of the Git core methods
LICENSE=	gnu-gpl-v2 # linking exception (linking allowed in more ways)

EXTRACT_USING=	bsdtar
USE_TOOLS+=	pkg-config
USE_CMAKE=	yes

PKGCONFIG_OVERRIDE+=	libgit2.pc.in
PYTHON_VERSIONS_INCOMPATIBLE=	33 34 # not yet ported as of 0.21.1

# Keep this build small and fast, drop any balast.
CMAKE_ARGS +=	-DBUILD_SHARED_LIBS=Off \
		-DBUILD_CLAR=Off \
		-DBUILD_EXAMPLES=Off

.include "../../security/libssh2/buildlink3.mk"
.include "../../security/openssl/buildlink3.mk"
.include "../../devel/zlib/buildlink3.mk"
.include "../../lang/python/pyversion.mk"
.include "../../mk/bsd.pkg.mk"
