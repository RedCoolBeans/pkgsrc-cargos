--- src/tar.c.orig
+++ src/tar.c
@@ -1341,14 +1341,18 @@
 static char const *const sort_mode_arg[] = {
   "none",
   "name",
+#if D_INO_IN_DIRENT
   "inode",
+#endif
   NULL
 };
 
 static int sort_mode_flag[] = {
     SAVEDIR_SORT_NONE,
     SAVEDIR_SORT_NAME,
+#if D_INO_IN_DIRENT
     SAVEDIR_SORT_INODE
+#endif
 };
 
 ARGMATCH_VERIFY (sort_mode_arg, sort_mode_flag);
