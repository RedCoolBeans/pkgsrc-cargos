# $NetBSD: Makefile,v 1.26 2015/03/08 16:57:12 taca Exp $

DISTNAME=	facter-2.4.4
PKGNAME=	${RUBY_PKGPREFIX}-${DISTNAME}
CATEGORIES=	sysutils

MAINTAINER=	tonnerre@NetBSD.org
HOMEPAGE=	http://www.puppetlabs.com/puppet/related-projects/facter/
COMMENT=	Cross-platform Ruby library for retrieving facts from OS
LICENSE=	gnu-gpl-v2

RUBYGEM_OPTIONS+=	--format-executable

DEPENDS+=	virt-what-[0-9]*:../../cargos/virt-what

.include "../../lang/ruby/gem.mk"
.include "../../mk/bsd.pkg.mk"
