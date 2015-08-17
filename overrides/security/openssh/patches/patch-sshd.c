$NetBSD: patch-sshd.c,v 1.3.12.1 2015/07/14 22:03:39 tron Exp $

* Interix support
* Revive tcp_wrappers support.

--- sshd.c.orig
+++ sshd.c
@@ -126,6 +126,13 @@
 #include "version.h"
 #include "ssherr.h"
 
+#ifdef LIBWRAP
+#include <tcpd.h>
+#include <syslog.h>
+int allow_severity;
+int deny_severity;
+#endif /* LIBWRAP */
+
 #ifndef O_NOCTTY
 #define O_NOCTTY	0
 #endif
@@ -237,7 +244,11 @@
 int startup_pipe;		/* in child */
 
 /* variables used for privilege separation */
+#ifdef HAVE_INTERIX
+int use_privsep = 0;
+#else
 int use_privsep = -1;
+#endif
 struct monitor *pmonitor = NULL;
 int privsep_is_preauth = 1;
 
@@ -644,10 +655,15 @@
 	/* XXX not ready, too heavy after chroot */
 	do_setusercontext(privsep_pw);
 #else
+#ifdef HAVE_INTERIX
+	if (setuser(privsep_pw->pw_name, NULL, SU_COMPLETE))
+		fatal("setuser: %.100s", strerror(errno));
+#else
 	gidset[0] = privsep_pw->pw_gid;
 	if (setgroups(1, gidset) < 0)
 		fatal("setgroups: %.100s", strerror(errno));
 	permanently_set_uid(privsep_pw);
+#endif /* HAVE_INTERIX */
 #endif
 }
 
@@ -715,7 +731,7 @@
 		set_log_handler(mm_log_handler, pmonitor);
 
 		/* Demote the child */
-		if (getuid() == 0 || geteuid() == 0)
+		if (getuid() == ROOTUID || geteuid() == ROOTUID)
 			privsep_preauth_child();
 		setproctitle("%s", "[net]");
 		if (box != NULL)
@@ -733,7 +749,7 @@
 #ifdef DISABLE_FD_PASSING
 	if (1) {
 #else
-	if (authctxt->pw->pw_uid == 0 || options.use_login) {
+	if (authctxt->pw->pw_uid == ROOTUID || options.use_login) {
 #endif
 		/* File descriptor passing is broken or root login */
 		use_privsep = 0;
@@ -1489,8 +1505,10 @@
 	av = saved_argv;
 #endif
 
-	if (geteuid() == 0 && setgroups(0, NULL) == -1)
+#ifndef HAVE_INTERIX
+	if (geteuid() == ROOTUID && setgroups(0, NULL) == -1)
 		debug("setgroups(): %.200s", strerror(errno));
+#endif
 
 	/* Ensure that fds 0, 1 and 2 are open or directed to /dev/null */
 	sanitise_stdfd();
@@ -1919,7 +1937,7 @@
 		    (st.st_uid != getuid () ||
 		    (st.st_mode & (S_IWGRP|S_IWOTH)) != 0))
 #else
-		if (st.st_uid != 0 || (st.st_mode & (S_IWGRP|S_IWOTH)) != 0)
+		if (st.st_uid != ROOTUID || (st.st_mode & (S_IWGRP|S_IWOTH)) != 0)
 #endif
 			fatal("%s must be owned by root and not group or "
 			    "world-writable.", _PATH_PRIVSEP_CHROOT_DIR);
@@ -1942,8 +1960,10 @@
 	 * to create a file, and we can't control the code in every
 	 * module which might be used).
 	 */
+#ifndef HAVE_INTERIX
 	if (setgroups(0, NULL) < 0)
 		debug("setgroups() failed: %.200s", strerror(errno));
+#endif
 
 	if (rexec_flag) {
 		rexec_argv = xcalloc(rexec_argc + 2, sizeof(char *));
@@ -2138,6 +2158,25 @@
 #ifdef SSH_AUDIT_EVENTS
 	audit_connection_from(remote_ip, remote_port);
 #endif
+
+#ifdef LIBWRAP
+	allow_severity = options.log_facility|LOG_INFO;
+	deny_severity = options.log_facility|LOG_WARNING;
+	/* Check whether logins are denied from this host. */
+	if (packet_connection_is_on_socket()) {
+		struct request_info req;
+
+		request_init(&req, RQ_DAEMON, __progname, RQ_FILE, sock_in, 0);
+		fromhost(&req);
+
+		if (!hosts_access(&req)) {
+			debug("Connection refused by tcp wrapper");
+			refuse(&req);
+			/* NOTREACHED */
+			fatal("libwrap refuse returns");
+		}
+	}
+#endif /* LIBWRAP */
 
 	/* Log the connection. */
 	laddr = get_local_ipaddr(sock_in);
