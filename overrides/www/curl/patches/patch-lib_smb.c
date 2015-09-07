$NetBSD$

Security fix for CVE-2015-3237
http://curl.haxx.se/docs/adv_20150617B.html

--- lib/smb.c.orig
+++ lib/smb.c
@@ -783,9 +783,15 @@
     off = Curl_read16_le(((unsigned char *) msg) +
                          sizeof(struct smb_header) + 13);
     if(len > 0) {
-      result = Curl_client_write(conn, CLIENTWRITE_BODY,
-                                 (char *)msg + off + sizeof(unsigned int),
-                                 len);
+      struct smb_conn *smbc = &conn->proto.smbc;
+      if(off + sizeof(unsigned int) + len > smbc->got) {
+        failf(conn->data, "Invalid input packet");
+        result = CURLE_RECV_ERROR;
+      }
+      else
+        result = Curl_client_write(conn, CLIENTWRITE_BODY,
+                                   (char *)msg + off + sizeof(unsigned int),
+                                   len);
       if(result) {
         req->result = result;
         next_state = SMB_CLOSE;
