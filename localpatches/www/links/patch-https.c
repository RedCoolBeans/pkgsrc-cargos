Fix build with LibreSSL.

--- https.c.orig
+++ https.c
@@ -36,11 +36,8 @@
 		unsigned os_pool_size;
 
 		const unsigned char *f = (const unsigned char *)RAND_file_name(cast_char f_randfile, sizeof(f_randfile));
-		if (f && RAND_egd(cast_const_char f) < 0) {
-			/* Not an EGD, so read and write to it */
-			if (RAND_load_file(cast_const_char f_randfile, -1))
-				RAND_write_file(cast_const_char f_randfile);
-		}
+		if (f && RAND_load_file(cast_const_char f_randfile, -1))
+			RAND_write_file(cast_const_char f_randfile);
 
 		os_seed_random(&os_pool, &os_pool_size);
 		if (os_pool_size) RAND_add(os_pool, os_pool_size, os_pool_size);
