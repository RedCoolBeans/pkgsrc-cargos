--- grub-core/gnulib/stdio.in.h.orig
+++ grub-core/gnulib/stdio.in.h
@@ -141,7 +141,6 @@
    so any use of gets warrants an unconditional warning.  Assume it is
    always declared, since it is required by C89.  */
 #undef gets
-_GL_WARN_ON_USE (gets, "gets is a security hole - use fgets instead");
 
 #if @GNULIB_FOPEN@
 # if @REPLACE_FOPEN@
