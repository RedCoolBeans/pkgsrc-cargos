Fix build with LibreSSL.

--- Lib/ssl.py.orig
+++ Lib/ssl.py
@@ -106,7 +106,7 @@
 from _ssl import (VERIFY_DEFAULT, VERIFY_CRL_CHECK_LEAF, VERIFY_CRL_CHECK_CHAIN,
     VERIFY_X509_STRICT)
 from _ssl import txt2obj as _txt2obj, nid2obj as _nid2obj
-from _ssl import RAND_status, RAND_egd, RAND_add
+from _ssl import RAND_status, RAND_add
 
 def _import_symbols(prefix):
     for n in dir(_ssl):
