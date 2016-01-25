--- ssh.c.orig
+++ ssh.c
@@ -1084,7 +1084,7 @@
 		    "disabling");
 		options.update_hostkeys = 0;
 	}
-#ifndef HAVE_CYGWIN
+#if defined(HAVE_CYGWIN) || defined(HAVE_INTERIX)
 	if (original_effective_uid != 0)
 		options.use_privileged_port = 0;
 #endif
@@ -1931,9 +1931,6 @@
 		} else
 			fork_postauth();
 	}
-
-	if (options.use_roaming)
-		request_roaming();
 
 	return client_loop(tty_flag, tty_flag ?
 	    options.escape_char : SSH_ESCAPECHAR_NONE, id);
