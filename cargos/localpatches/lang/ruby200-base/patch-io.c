--- io.c.orig
+++ io.c
@@ -19,6 +19,7 @@
 #include "id.h"
 #include <ctype.h>
 #include <errno.h>
+#include <asm/ioctl.h>
 #include "ruby_atomic.h"
 
 #define free(x) xfree(x)
