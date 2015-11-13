Fix build with LibreSSL.

--- ext/openssl/ossl_rand.c.orig
+++ ext/openssl/ossl_rand.c
@@ -127,40 +127,6 @@
 
 /*
  *  call-seq:
- *     egd(filename) -> true
- *
- */
-static VALUE
-ossl_rand_egd(VALUE self, VALUE filename)
-{
-    SafeStringValue(filename);
-
-    if(!RAND_egd(RSTRING_PTR(filename))) {
-	ossl_raise(eRandomError, NULL);
-    }
-    return Qtrue;
-}
-
-/*
- *  call-seq:
- *     egd_bytes(filename, length) -> true
- *
- */
-static VALUE
-ossl_rand_egd_bytes(VALUE self, VALUE filename, VALUE len)
-{
-    int n = NUM2INT(len);
-
-    SafeStringValue(filename);
-
-    if (!RAND_egd_bytes(RSTRING_PTR(filename), n)) {
-	ossl_raise(eRandomError, NULL);
-    }
-    return Qtrue;
-}
-
-/*
- *  call-seq:
  *     status? => true | false
  *
  * Return true if the PRNG has been seeded with enough data, false otherwise.
@@ -195,8 +161,6 @@
     DEFMETH(mRandom, "write_random_file", ossl_rand_write_file, 1);
     DEFMETH(mRandom, "random_bytes", ossl_rand_bytes, 1);
     DEFMETH(mRandom, "pseudo_bytes", ossl_rand_pseudo_bytes, 1);
-    DEFMETH(mRandom, "egd", ossl_rand_egd, 1);
-    DEFMETH(mRandom, "egd_bytes", ossl_rand_egd_bytes, 2);
     DEFMETH(mRandom, "status?", ossl_rand_status, 0)
 }
 
