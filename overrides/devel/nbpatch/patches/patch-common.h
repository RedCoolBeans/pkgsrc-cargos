$NetBSD$

--- common.h.orig
+++ common.h
@@ -51,12 +51,10 @@
 #define BUFFERSIZE 1024
 
 #define SCCSPREFIX "s."
-#define GET "get -e %s"
-#define SCCSDIFF "get -p %s | diff - %s >/dev/null"
 
 #define RCSSUFFIX ",v"
-#define CHECKOUT "co -l %s"
-#define RCSDIFF "rcsdiff %s > /dev/null"
+#define CHECKOUT "/usr/bin/co"
+#define RCSDIFF "/usr/bin/rcsdiff"
 
 #define ORIGEXT ".orig"
 #define REJEXT ".rej"
@@ -135,4 +133,3 @@
 extern LINENUM	input_lines;	/* how long is input file in lines */
 
 extern int	posix;
-
