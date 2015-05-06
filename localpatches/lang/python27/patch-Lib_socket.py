Fix build with LibreSSL.

--- Lib/socket.py.orig
+++ Lib/socket.py
@@ -67,7 +67,6 @@
     from _ssl import SSLError as sslerror
     from _ssl import \
          RAND_add, \
-         RAND_egd, \
          RAND_status, \
          SSL_ERROR_ZERO_RETURN, \
          SSL_ERROR_WANT_READ, \
