--- theo.c.orig
+++ theo.c
@@ -37,7 +37,6 @@
 #  include <sys/time.h>
 #endif
 
-
 void		theo_init(void);
 static int	theo_analyze(int, int);
 static int	theo(int, int);
@@ -218,14 +217,14 @@
 {
 	const char	*str;
 	int		 len;
-	uint             random;
+	unsigned int             random;
 #ifndef HAVE_ARC4RANDOM
 	struct timeval	tv[2];
 
 	gettimeofday(&tv[0], NULL);
-	random = (uint)tv[0].tv_usec;
+	random = (unsigned int)tv[0].tv_usec;
 #else
-	random = (uint)arc4random();
+	random = (unsigned int)arc4random();
 #endif
 
 	str = talk[random % ntalk];
