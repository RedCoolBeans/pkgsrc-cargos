PKGNAME=	${DISTNAME:S/-/-static-/}
PKGREVISION=	1

COMMENT=	Portable, pure C implementation of the Git core methods

# Keep this build small and fast, drop any balast.
CMAKE_ARGS +=	-DBUILD_SHARED_LIBS=Off \
		-DBUILD_CLAR=Off \
		-DBUILD_EXAMPLES=Off

.include "../libgit2/Makefile.common"
