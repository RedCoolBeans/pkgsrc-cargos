# $NetBSD$

DISTNAME=		virt-what-1.15
CATEGORIES=		sysutils
MASTER_SITES=		http://people.redhat.com/~rjones/virt-what/files/
PKGREVISION=		1

MAINTAINER=		pkgsrc@cargos.io
HOMEPAGE=		http://people.redhat.com/~rjones/virt-what/
COMMENT=		Detect if we are running in a virtual machine
LICENSE=		gnu-gpl-v2

DEPENDS +=		dmidecode-[0-9]*:../../sysutils/dmidecode

USE_TOOLS=		pod2man

GNU_CONFIGURE=		Yes

.include "../../mk/bsd.pkg.mk"
