Fix build with LibreSSL.

--- Modules/_ssl.c.orig
+++ Modules/_ssl.c
@@ -3301,32 +3301,6 @@
 It is necessary to seed the PRNG with RAND_add() on some platforms before\n\
 using the ssl() function.");
 
-static PyObject *
-PySSL_RAND_egd(PyObject *self, PyObject *arg)
-{
-    int bytes;
-
-    if (!PyString_Check(arg))
-        return PyErr_Format(PyExc_TypeError,
-                            "RAND_egd() expected string, found %s",
-                            Py_TYPE(arg)->tp_name);
-    bytes = RAND_egd(PyString_AS_STRING(arg));
-    if (bytes == -1) {
-        PyErr_SetString(PySSLErrorObject,
-                        "EGD connection failed or EGD did not return "
-                        "enough data to seed the PRNG");
-        return NULL;
-    }
-    return PyInt_FromLong(bytes);
-}
-
-PyDoc_STRVAR(PySSL_RAND_egd_doc,
-"RAND_egd(path) -> bytes\n\
-\n\
-Queries the entropy gather daemon (EGD) on the socket named by 'path'.\n\
-Returns number of bytes read.  Raises SSLError if connection to EGD\n\
-fails or if it does not provide enough data to seed PRNG.");
-
 #endif /* HAVE_OPENSSL_RAND */
 
 
@@ -3720,8 +3694,6 @@
 #ifdef HAVE_OPENSSL_RAND
     {"RAND_add",            PySSL_RAND_add, METH_VARARGS,
      PySSL_RAND_add_doc},
-    {"RAND_egd",            PySSL_RAND_egd, METH_VARARGS,
-     PySSL_RAND_egd_doc},
     {"RAND_status",         (PyCFunction)PySSL_RAND_status, METH_NOARGS,
      PySSL_RAND_status_doc},
 #endif
