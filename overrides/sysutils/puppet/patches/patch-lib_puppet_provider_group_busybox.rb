$NetBSD$

--- lib/puppet/provider/group/busybox.rb.orig
+++ lib/puppet/provider/group/busybox.rb
@@ -0,0 +1,20 @@
+require 'puppet/provider/nameservice/objectadd'
+require 'date'
+require 'time'
+require 'puppet/error'
+
+Puppet::Type.type(:group).provide :busybox, :parent => Puppet::Provider::NameService::ObjectAdd do
+  desc "Local group management for Busybox"
+
+  commands :busybox => "busybox"
+
+  def addmcd
+    debug "Called addcmd"
+    busybox(:addgroup)
+  end
+
+  def delcmd
+    debug "Called delcmd"
+    busybox(:delgroup)
+  end
+end
