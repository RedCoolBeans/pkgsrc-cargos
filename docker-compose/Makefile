# $NetBSD$

DISTNAME=		docker-compose-1.2.0
CATEGORIES=		sysutils
MASTER_SITES=		https://pypi.python.org/packages/source/d/docker-compose/

MAINTAINER=		pkgsrc@cargos.io
HOMEPAGE=		http://docs.docker.com/compose/
COMMENT=		Define and run complex applications using Docker
LICENSE=		apache-2.0

DEPENDS+=		docker.io-[0-9]*:../../cargos/docker.io
DEPENDS+=		${PYPKGPREFIX}-docker-[0-9]*:../../cargos/py-docker
DEPENDS+=		${PYPKGPREFIX}-dockerpty-[0-9]*:../../cargos/py-dockerpty
DEPENDS+=		${PYPKGPREFIX}-docopt-[0-9]*:../../devel/py-docopt
DEPENDS+=		${PYPKGPREFIX}-requests-[0-9]*:../../devel/py-requests
DEPENDS+=		${PYPKGPREFIX}-six-[0-9]*:../../lang/py-six
DEPENDS+=		${PYPKGPREFIX}-texttable-[0-9]*:../../cargos/py-texttable
DEPENDS+=		${PYPKGPREFIX}-websocket-client-[0-9]*:../../cargos/py-websocket-client
DEPENDS+=		${PYPKGPREFIX}-yaml-[0-9]*:../../textproc/py-yaml

.include "../../lang/python/egg.mk"
.include "../../mk/bsd.pkg.mk"
