--- gcc/gcc.c.orig
+++ gcc/gcc.c
@@ -672,7 +672,7 @@
 #ifdef TARGET_LIBC_PROVIDES_SSP
 #define LINK_SSP_SPEC "%{fstack-protector:}"
 #else
-#define LINK_SSP_SPEC "%{fstack-protector|fstack-protector-strong|fstack-protector-all:-lssp_nonshared -lssp}"
+#define LINK_SSP_SPEC "-lssp_nonshared"
 #endif
 #endif
 
