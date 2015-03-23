# $NetBSD$
#

COMMENT=        CargOS specific packages and overrides

SUBDIR+=	cargos-build-essential
SUBDIR+=	cargos-release
SUBDIR+=	cargos-user_busybox
SUBDIR+=	docker-compose
SUBDIR+=	docker.io

.include "../mk/misc/category.mk"
