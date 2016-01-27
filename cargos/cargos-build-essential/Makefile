# $NetBSD$

DISTNAME=		cargos-build-essential-2016.02
CATEGORIES=		devel meta-pkgs
MASTER_SITES=		# empty
DISTFILES=		# empty

MAINTAINER=		pkgsrc@cargos.io
HOMEPAGE=		http://cargos.io/
COMMENT=		CargOS build environment
LICENSE=		isc

META_PACKAGE=		yes

# pkgsrc
DEPENDS +=		bmake-[0-9]*:../../devel/bmake
DEPENDS +=		bootstrap-mk-files-[0-9]*:../../pkgtools/bootstrap-mk-files
DEPENDS +=		digest-[0-9]*:../../pkgtools/digest
DEPENDS +=		file-[0-9]*:../../sysutils/file
DEPENDS +=		gcc49>=4.9:../../lang/gcc49
DEPENDS +=		gnupg-[0-9]*:../../security/gnupg
DEPENDS +=		nbpatch-[0-9]*:../../devel/nbpatch
DEPENDS +=		wget-[0-9]*:../../net/wget

# cargos
DEPENDS +=		cargos-release-[0-9]*:../../cargos/cargos-release
DEPENDS +=		git-base-[0-9]*:../../devel/git-base

.include "../../mk/bsd.pkg.mk"
