$NetBSD: patch-lib_hostcheck.c,v 1.1 2014/03/31 08:45:21 wiz Exp $

Add missing header for DragonflyBSD.
PR 48691 by David Shao.

--- lib/hostcheck.c.orig
+++ lib/hostcheck.c
@@ -34,6 +34,13 @@
 #include "inet_pton.h"
 
 #include "curl_memory.h"
+
+#ifdef ENABLE_IPV6
+#ifdef HAVE_NETINET_IN_H
+#include <netinet/in.h>
+#endif
+#endif
+
 /* The last #include file should be: */
 #include "memdebug.h"
 
