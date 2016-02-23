--- grub-core/normal/auth.c.orig
+++ grub-core/normal/auth.c
@@ -172,7 +172,7 @@
 	  break;
 	}
 
-      if (key == '\b')
+      if (key == '\b' && cur_len)
 	{
 	  cur_len--;
 	  grub_printf ("\b");
