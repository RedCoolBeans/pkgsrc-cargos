# @PKGNAME@
# @EGDIR@/etc/profile.d/pkg.sh

# PATH
PATH=${PATH}:@LOCALBASE@/sbin:@LOCALBASE@/bin			# pkg PREFIX
#PATH=${PATH}:@LOCALBASE@/gnu/bin				# GNU overrides
PATH=${PATH}:@LOCALBASE@/gcc47/bin				# GCC

# MANPATH
MANPATH=/usr/share/man						# buildroot
MANPATH=${MANPATH}:@LOCALBASE@/man				# pkg PREFIX
MANPATH=${MANPATH}:@LOCALBASE@/gcc47/man			# GCC
MANPATH=${MANPATH}:@LOCALBASE@/lib/perl5/vendor_perl/man	# perl
MANPATH=${MANPATH}:@LOCALBASE@/lib/perl5/man			# perl

export MANPATH PATH
