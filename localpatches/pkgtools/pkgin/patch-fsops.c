--- fsops.c.orig
+++ fsops.c
@@ -125,7 +125,10 @@
 	while (!feof(fp)) {
 		memset(buf, 0, BUFSIZ);
 
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wunused-result"
 		(void)fgets(buf, BUFSIZ, fp);
+#pragma GCC diagnostic pop
 
 		if (strncmp(buf, "ftp://", 6) != 0 &&
 			strncmp(buf, "http://", 7) != 0 &&
