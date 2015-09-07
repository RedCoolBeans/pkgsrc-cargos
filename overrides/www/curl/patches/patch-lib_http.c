$NetBSD$

Security fix for CVE-2015-3236
http://curl.haxx.se/docs/adv_20150617A.html

--- lib/http.c.orig
+++ lib/http.c
@@ -2280,20 +2280,12 @@
                      te
       );
 
-  /*
-   * Free userpwd for Negotiate/NTLM. Cannot reuse as it is associated with
-   * the connection and shouldn't be repeated over it either.
-   */
-  switch (data->state.authhost.picked) {
-  case CURLAUTH_NEGOTIATE:
-  case CURLAUTH_NTLM:
-  case CURLAUTH_NTLM_WB:
-    Curl_safefree(conn->allocptr.userpwd);
-    break;
-  }
+  /* clear userpwd to avoid re-using credentials from re-used connections */
+  Curl_safefree(conn->allocptr.userpwd);
 
   /*
-   * Same for proxyuserpwd
+   * Free proxyuserpwd for Negotiate/NTLM. Cannot reuse as it is associated
+   * with the connection and shouldn't be repeated over it either.
    */
   switch (data->state.authproxy.picked) {
   case CURLAUTH_NEGOTIATE:
