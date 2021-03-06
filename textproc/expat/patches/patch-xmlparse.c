$NetBSD: patch-xmlparse.c,v 1.1 2015/08/04 08:47:19 tnn Exp $

CVE-2015-1283 heap based buffer overflow in expat.

https://hg.mozilla.org/releases/mozilla-esr31/raw-diff/2f3e78643f5c/parser/expat/lib/xmlparse.c

diff --git a/parser/expat/lib/xmlparse.c b/parser/expat/lib/xmlparse.c
--- lib/xmlparse.c
+++ lib/xmlparse.c
@@ -1646,29 +1646,40 @@ XML_ParseBuffer(XML_Parser parser, int l
   XmlUpdatePosition(encoding, positionPtr, bufferPtr, &position);
   positionPtr = bufferPtr;
   return result;
 }
 
 void * XMLCALL
 XML_GetBuffer(XML_Parser parser, int len)
 {
+/* BEGIN MOZILLA CHANGE (sanity check len) */
+  if (len < 0) {
+    errorCode = XML_ERROR_NO_MEMORY;
+    return NULL;
+  }
+/* END MOZILLA CHANGE */
   switch (ps_parsing) {
   case XML_SUSPENDED:
     errorCode = XML_ERROR_SUSPENDED;
     return NULL;
   case XML_FINISHED:
     errorCode = XML_ERROR_FINISHED;
     return NULL;
   default: ;
   }
 
   if (len > bufferLim - bufferEnd) {
-    /* FIXME avoid integer overflow */
     int neededSize = len + (int)(bufferEnd - bufferPtr);
+/* BEGIN MOZILLA CHANGE (sanity check neededSize) */
+    if (neededSize < 0) {
+      errorCode = XML_ERROR_NO_MEMORY;
+      return NULL;
+    }
+/* END MOZILLA CHANGE */
 #ifdef XML_CONTEXT_BYTES
     int keep = (int)(bufferPtr - buffer);
 
     if (keep > XML_CONTEXT_BYTES)
       keep = XML_CONTEXT_BYTES;
     neededSize += keep;
 #endif  /* defined XML_CONTEXT_BYTES */
     if (neededSize  <= bufferLim - buffer) {
@@ -1687,17 +1698,25 @@ XML_GetBuffer(XML_Parser parser, int len
     }
     else {
       char *newBuf;
       int bufferSize = (int)(bufferLim - bufferPtr);
       if (bufferSize == 0)
         bufferSize = INIT_BUFFER_SIZE;
       do {
         bufferSize *= 2;
-      } while (bufferSize < neededSize);
+/* BEGIN MOZILLA CHANGE (prevent infinite loop on overflow) */
+      } while (bufferSize < neededSize && bufferSize > 0);
+/* END MOZILLA CHANGE */
+/* BEGIN MOZILLA CHANGE (sanity check bufferSize) */
+      if (bufferSize <= 0) {
+        errorCode = XML_ERROR_NO_MEMORY;
+        return NULL;
+      }
+/* END MOZILLA CHANGE */
       newBuf = (char *)MALLOC(bufferSize);
       if (newBuf == 0) {
         errorCode = XML_ERROR_NO_MEMORY;
         return NULL;
       }
       bufferLim = newBuf + bufferSize;
 #ifdef XML_CONTEXT_BYTES
       if (bufferPtr) {
