grub-core/lib/crypto.c:431:3: error: ignoring return value of 'fgets', declared with attribute warn_unused_result [-Werror=unused-result]
   fgets (buf, buf_size, stdin);

--- grub-core/lib/crypto.c.orig
+++ grub-core/lib/crypto.c
@@ -428,7 +428,11 @@
     }
   else
     tty_changed = 0;
-  fgets (buf, buf_size, stdin);
+  if (!fgets (buf, buf_size, stdin))
+    {
+      fclose (in);
+      return 0;
+    }
   ptr = buf + strlen (buf) - 1;
   while (buf <= ptr && (*ptr == '\n' || *ptr == '\r'))
     *ptr-- = 0;
