--- grub-core/kern/emu/hostdisk.c.orig
+++ grub-core/kern/emu/hostdisk.c
@@ -44,11 +44,6 @@
 #ifdef __linux__
 # include <sys/ioctl.h>         /* ioctl */
 # include <sys/mount.h>
-# if !defined(__GLIBC__) || \
-        ((__GLIBC__ < 2) || ((__GLIBC__ == 2) && (__GLIBC_MINOR__ < 1)))
-/* Maybe libc doesn't have large file support.  */
-#  include <linux/unistd.h>     /* _llseek */
-# endif /* (GLIBC < 2) || ((__GLIBC__ == 2) && (__GLIBC_MINOR < 1)) */
 # ifndef BLKFLSBUF
 #  define BLKFLSBUF     _IO (0x12,97)   /* flush buffer cache */
 # endif /* ! BLKFLSBUF */
@@ -761,28 +756,9 @@
 }
 #endif /* __linux__ */
 
-#if defined(__linux__) && (!defined(__GLIBC__) || \
-        ((__GLIBC__ < 2) || ((__GLIBC__ == 2) && (__GLIBC_MINOR__ < 1))))
-  /* Maybe libc doesn't have large file support.  */
 grub_err_t
 grub_util_fd_seek (int fd, const char *name, grub_uint64_t off)
 {
-  loff_t offset, result;
-  static int _llseek (uint filedes, ulong hi, ulong lo,
-		      loff_t *res, uint wh);
-  _syscall5 (int, _llseek, uint, filedes, ulong, hi, ulong, lo,
-	     loff_t *, res, uint, wh);
-
-  offset = (loff_t) off;
-  if (_llseek (fd, offset >> 32, offset & 0xffffffff, &result, SEEK_SET))
-    return grub_error (GRUB_ERR_BAD_DEVICE, N_("cannot seek `%s': %s"),
-		       name, strerror (errno));
-  return GRUB_ERR_NONE;
-}
-#else
-grub_err_t
-grub_util_fd_seek (int fd, const char *name, grub_uint64_t off)
-{
   off_t offset = (off_t) off;
 
   if (lseek (fd, offset, SEEK_SET) != offset)
@@ -790,7 +766,6 @@
 		       name, strerror (errno));
   return 0;
 }
-#endif
 
 static void
 flush_initial_buffer (const char *os_dev __attribute__ ((unused)))
