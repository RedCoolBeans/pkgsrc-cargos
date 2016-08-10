--- missing/isnan.c.orig
+++ missing/isnan.c
@@ -4,6 +4,8 @@
 
 static int double_ne(double n1, double n2);
 
+#undef isnan
+
 int
 isnan(double n)
 {
