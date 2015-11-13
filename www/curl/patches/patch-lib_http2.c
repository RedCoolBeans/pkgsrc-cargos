$NetBSD: patch-lib_http2.c,v 1.1 2015/06/03 12:00:06 fhajny Exp $

Update compatibility for nghttp2 1.0. This patch should become obsolete
with curl-7.43.

--- lib/http2.c.orig
+++ lib/http2.c
@@ -1019,8 +1019,8 @@
 
   rv = (int) ((Curl_send*)httpc->send_underlying)
     (conn, FIRSTSOCKET,
-     NGHTTP2_CLIENT_CONNECTION_PREFACE,
-     NGHTTP2_CLIENT_CONNECTION_PREFACE_LEN,
+     NGHTTP2_CLIENT_MAGIC,
+     NGHTTP2_CLIENT_MAGIC_LEN,
      &result);
   if(result)
     /* TODO: This may get CURLE_AGAIN */
