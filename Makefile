# $NetBSD$
#

COMMENT=        CargOS specific packages and overrides

SUBDIR+=	cargos-build-essential
SUBDIR+=	cargos-release
SUBDIR+=	cargos-user_busybox
SUBDIR+=	docker-compose
SUBDIR+=	docker-machine
SUBDIR+=	docker.io
SUBDIR+=	py-docker
SUBDIR+=	py-dockerpty
SUBDIR+=	py-texttable
SUBDIR+=	py-websocket-client

.include "../mk/misc/category.mk"
