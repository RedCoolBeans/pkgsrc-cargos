#!@RCD_SCRIPTS_SHELL@
#
# $NetBSD $
#
# PROVIDE: dockerd
# REQUIRE: DAEMON
# KEYWORD: shutdown

. /etc/rc.subr

name="dockerd"
rcvar=$name
command="@PREFIX@/bin/$name"
start_cmd=docker_start

docker_start()
{
	@ECHO@ "Starting ${name}."
	nohup ${command} ${command_args} ${dockerd_flags} >/dev/null 2>&1 &
}


load_rc_config $name
run_rc_command "$1"
