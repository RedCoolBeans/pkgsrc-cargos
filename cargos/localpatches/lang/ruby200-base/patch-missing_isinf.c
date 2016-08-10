--- ./missing/isinf.c.orig
+++ ./missing/isinf.c
@@ -52,6 +52,8 @@
 static double one (void) { return 1.0; }
 static double inf (void) { return one() / zero(); }
 
+#undef isinf
+
 int
 isinf(double n)
 {
