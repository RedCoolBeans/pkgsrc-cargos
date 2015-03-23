# $NetBSD$

V=			1.1.0
DISTNAME=		docker-compose-${V}
CATEGORIES=		sysutils
MASTER_SITES=		https://pypi.python.org/packages/source/d/docker-compose/

MAINTAINER=		pkgsrc@cargos.io
HOMEPAGE=		http://docs.docker.com/compose/
COMMENT=		Define and run complex applications using Docker
LICENSE=		apache-2.0

DEPENDS+=		docker.io-[0-9]*:../../cargos/docker.io
DEPENDS+=		${PYPKGPREFIX}-pip-[0-9]*:../../devel/py-pip

.include "../../lang/python/egg.mk"
.include "../../mk/bsd.pkg.mk"
