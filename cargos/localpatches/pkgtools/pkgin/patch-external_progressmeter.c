-D_FORTIFY_SOURCE=2

--- external/progressmeter.c.orig
+++ external/progressmeter.c
@@ -236,7 +236,10 @@
 			strlcat(buf, "    ", win_size);
 	}
 
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wunused-result"
 	write(STDOUT_FILENO, buf, win_size - 1);
+#pragma GCC diagnostic pop
 	last_update = now;
 	last_pos = cur_pos;
 }
@@ -293,7 +296,10 @@
 	if (cur_pos != end_pos)
 		refresh_progress_meter();
 
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wunused-result"
 	write(STDOUT_FILENO, "\n", 1);
+#pragma GCC diagnostic pop
 }
 
 /*ARGSUSED*/
