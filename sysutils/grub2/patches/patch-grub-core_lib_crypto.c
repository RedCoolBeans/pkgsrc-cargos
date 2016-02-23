--- ./grub-core/lib/crypto.c.orig
+++ ./grub-core/lib/crypto.c
@@ -460,7 +460,7 @@
 	  break;
 	}
 
-      if (key == '\b')
+      if (key == '\b' && cur_len)
 	{
 	  cur_len--;
 	  continue;
