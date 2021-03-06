# @PKGNAME@
# @EGDIR@/etc/profile.d/pkg.sh

# PATH
PATH=/usr/bin:/bin:/usr/sbin:/sbin			# RO base
PATH=${PATH}:@LOCALBASE@/sbin:@LOCALBASE@/bin			# pkg PREFIX
#PATH=${PATH}:@LOCALBASE@/gnu/bin				# GNU overrides
PATH=${PATH}:@LOCALBASE@/gcc49/bin				# GCC

# MANPATH
MANPATH=/usr/share/man					# buildroot
MANPATH=${MANPATH}:@LOCALBASE@/man				# pkg PREFIX
MANPATH=${MANPATH}:@LOCALBASE@/gcc49/man			# GCC
MANPATH=${MANPATH}:@LOCALBASE@/lib/perl5/vendor_perl/man	# perl
MANPATH=${MANPATH}:@LOCALBASE@/lib/perl5/man		# perl

# PKG_REPOS (see pkgin(1))
PKG_REPOS=http://download.cargos.io/@VERSION@/@MACHINE@/packages/All

export MANPATH PATH PKG_REPOS
