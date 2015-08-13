#!@RCD_SCRIPTS_SHELL@
#
# $NetBSD $
#
# PROVIDE: docker
# REQUIRE: DAEMON
# KEYWORD: shutdown

. /etc/rc.subr

name="docker"
rcvar=$name
command="@PREFIX@/bin/$name"
command_args="daemon"
start_cmd=docker_start

docker_start()
{
	@ECHO@ "Starting ${name}."
	nohup ${command} ${command_args} ${docker_flags} >/dev/null 2>&1 &
}


load_rc_config $name
run_rc_command "$1"
