#!@RCD_SCRIPTS_SHELL@
#
# $NetBSD: puppetmasterd.sh,v 1.3 2013/04/10 21:10:55 tonnerre Exp $
#
# PROVIDE: puppetmasterd
# REQUIRE: DAEMON
# KEYWORD: shutdown

# Add the following lines to /etc/rc.conf to enable puppetmasterd:
#
# puppetmasterd="YES"
# puppetmasterd_confdir:	Set to @PKG_SYSCONFDIR@ by default
# puppetmasterd_flags:		Set to master --confdir $puppetmasterd_confdir --rundir /var/run" by default
#

if [ -f /etc/rc.subr ]; then
	$_rc_subr_loaded . /etc/rc.subr
fi

name="puppetmasterd"
rcvar=$name
command="@PREFIX@/bin/puppet"
command_interpreter="@RUBY@"
: ${puppetmasterd_confdir="@PKG_SYSCONFDIR@"}
: ${puppetmasterd_pid="/var/run/master.pid"}
: ${puppetmasterd_flags="master --confdir $puppetmasterd_confdir --rundir /var/run"}

pidfile="$puppetmasterd_pid"

if [ -f /etc/rc.subr -a -d /etc/rc.d -a -f /etc/rc.d/DAEMON ]; then
	load_rc_config "$name"
elif [ -f /etc/rc.conf ]; then
	. /etc/rc.conf
fi

run_rc_command "$1"
