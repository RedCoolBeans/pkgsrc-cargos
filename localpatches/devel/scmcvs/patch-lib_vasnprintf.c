From 913c09becd9df89dbd9b9f386e7f35c240d5efe8 Mon Sep 17 00:00:00 2001
From: Bruno Haible <bruno@clisp.org>
Date: Thu, 18 Oct 2007 23:50:42 +0000
Subject: Don't use %n on glibc >= 2.3 systems.

--- lib/vasnprintf.c.orig
+++ lib/vasnprintf.c
@@ -558,9 +558,21 @@
 		  }
 		*p = dp->conversion;
 #if USE_SNPRINTF
+# if !(__GLIBC__ > 2 || (__GLIBC__ == 2 && __GLIBC_MINOR__ >= 3))
 		p[1] = '%';
 		p[2] = 'n';
 		p[3] = '\0';
+# else
+		/* On glibc2 systems from glibc >= 2.3 - probably also older
+		   ones - we know that snprintf's returns value conforms to
+		   ISO C 99: the gl_SNPRINTF_DIRECTIVE_N test passes.
+		   Therefore we can avoid using %n in this situation.
+		   On glibc2 systems from 2004-10-18 or newer, the use of %n
+		   in format strings in writable memory may crash the program
+		   (if compiled with _FORTIFY_SOURCE=2), so we should avoid it
+		   in this situation.  */
+		p[1] = '\0';
+# endif
 #else
 		p[1] = '\0';
 #endif
