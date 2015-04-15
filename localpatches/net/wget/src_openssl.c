Fix build with LibreSSL

--- src/openssl.c.orig
+++ src/openssl.c
@@ -91,9 +91,11 @@
   if (RAND_status ())
     return;
 
+#if 0 /* LibreSSL */
   /* Get random data from EGD if opt.egd_file was used.  */
   if (opt.egd_file && *opt.egd_file)
     RAND_egd (opt.egd_file);
+#endif
 
   if (RAND_status ())
     return;
