$NetBSD$

--- lib/puppet/provider/user/busybox.rb.orig
+++ lib/puppet/provider/user/busybox.rb
@@ -0,0 +1,20 @@
+require 'puppet/provider/nameservice/objectadd'
+require 'date'
+require 'time'
+require 'puppet/error'
+
+Puppet::Type.type(:user).provide :busybox, :parent => Puppet::Provider::NameService::ObjectAdd do
+  desc "Local user management for Busybox"
+
+  commands :busybox => "busybox"
+
+  def addmcd
+    debug "Called addcmd"
+    busybox(:adduser)
+  end
+
+  def delcmd
+    debug "Called delcmd"
+    busybox(:deluser)
+  end
+end
