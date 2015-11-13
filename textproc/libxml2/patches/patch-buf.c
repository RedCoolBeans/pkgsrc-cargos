$NetBSD: patch-buf.c,v 1.1 2015/04/24 11:32:29 spz Exp $

patch for CVE-2015-1819 Enforce the reader to run in constant memory
from https://git.gnome.org/browse/libxml2/commit/?id=213f1fe0d76d30eaed6e5853057defc43e6df2c9
part 1

--- buf.c.orig	2014-10-13 08:01:31.000000000 +0000
+++ buf.c
@@ -27,6 +27,7 @@
 #include <libxml/tree.h>
 #include <libxml/globals.h>
 #include <libxml/tree.h>
+#include <libxml/parserInternals.h> /* for XML_MAX_TEXT_LENGTH */
 #include "buf.h"
 
 #define WITH_BUFFER_COMPAT
@@ -299,7 +300,8 @@ xmlBufSetAllocationScheme(xmlBufPtr buf,
     if ((scheme == XML_BUFFER_ALLOC_DOUBLEIT) ||
         (scheme == XML_BUFFER_ALLOC_EXACT) ||
         (scheme == XML_BUFFER_ALLOC_HYBRID) ||
-        (scheme == XML_BUFFER_ALLOC_IMMUTABLE)) {
+        (scheme == XML_BUFFER_ALLOC_IMMUTABLE) ||
+        (scheme == XML_BUFFER_ALLOC_BOUNDED)) {
 	buf->alloc = scheme;
         if (buf->buffer)
             buf->buffer->alloc = scheme;
@@ -458,6 +460,18 @@ xmlBufGrowInternal(xmlBufPtr buf, size_t
     size = buf->use + len + 100;
 #endif
 
+    if (buf->alloc == XML_BUFFER_ALLOC_BOUNDED) {
+        /*
+	 * Used to provide parsing limits
+	 */
+        if ((buf->use + len >= XML_MAX_TEXT_LENGTH) ||
+	    (buf->size >= XML_MAX_TEXT_LENGTH)) {
+	    xmlBufMemoryError(buf, "buffer error: text too long\n");
+	    return(0);
+	}
+	if (size >= XML_MAX_TEXT_LENGTH)
+	    size = XML_MAX_TEXT_LENGTH;
+    }
     if ((buf->alloc == XML_BUFFER_ALLOC_IO) && (buf->contentIO != NULL)) {
         size_t start_buf = buf->content - buf->contentIO;
 
@@ -738,7 +752,15 @@ xmlBufResize(xmlBufPtr buf, size_t size)
         return(0);
     CHECK_COMPAT(buf)
 
-    if (buf->alloc == XML_BUFFER_ALLOC_IMMUTABLE) return(0);
+    if (buf->alloc == XML_BUFFER_ALLOC_BOUNDED) {
+        /*
+	 * Used to provide parsing limits
+	 */
+        if (size >= XML_MAX_TEXT_LENGTH) {
+	    xmlBufMemoryError(buf, "buffer error: text too long\n");
+	    return(0);
+	}
+    }
 
     /* Don't resize if we don't have to */
     if (size < buf->size)
@@ -867,6 +889,15 @@ xmlBufAdd(xmlBufPtr buf, const xmlChar *
 
     needSize = buf->use + len + 2;
     if (needSize > buf->size){
+	if (buf->alloc == XML_BUFFER_ALLOC_BOUNDED) {
+	    /*
+	     * Used to provide parsing limits
+	     */
+	    if (needSize >= XML_MAX_TEXT_LENGTH) {
+		xmlBufMemoryError(buf, "buffer error: text too long\n");
+		return(-1);
+	    }
+	}
         if (!xmlBufResize(buf, needSize)){
 	    xmlBufMemoryError(buf, "growing buffer");
             return XML_ERR_NO_MEMORY;
@@ -938,6 +969,15 @@ xmlBufAddHead(xmlBufPtr buf, const xmlCh
     }
     needSize = buf->use + len + 2;
     if (needSize > buf->size){
+	if (buf->alloc == XML_BUFFER_ALLOC_BOUNDED) {
+	    /*
+	     * Used to provide parsing limits
+	     */
+	    if (needSize >= XML_MAX_TEXT_LENGTH) {
+		xmlBufMemoryError(buf, "buffer error: text too long\n");
+		return(-1);
+	    }
+	}
         if (!xmlBufResize(buf, needSize)){
 	    xmlBufMemoryError(buf, "growing buffer");
             return XML_ERR_NO_MEMORY;
