--- sysdef.h.orig
+++ sysdef.h
@@ -9,6 +9,7 @@
 #include	"config.h"
 
 #include <sys/param.h>
+#include <sys/stat.h>
 
 /* This is the queue.h from OpenBSD/NetBSD, works fine. The one provided by
    others is incompatible. */
@@ -31,6 +32,7 @@
 #include <string.h>
 #include <errno.h>
 #include <signal.h>
+#include <time.h>
 
 
 #define	KBLOCK		8192	/* Kill grow.			 */
