--- /home/cargos/pkgsrc-work/pkgtools/pkgin/work/pkgin-0.9.4/external/progressmeter.h.orig
+++ /home/cargos/pkgsrc-work/pkgtools/pkgin/work/pkgin-0.9.4/external/progressmeter.h
@@ -31,7 +31,7 @@
 #include <nbcompat.h>
 #endif
 
-#if defined(HAVE_SYS_TERMIOS_H) && !defined(__FreeBSD__)
+#if defined(HAVE_SYS_TERMIOS_H) && !defined(__FreeBSD__) && defined(__GLIBC__)
 #include <sys/termios.h>
 #elif HAVE_TERMIOS_H
 #include <termios.h>
