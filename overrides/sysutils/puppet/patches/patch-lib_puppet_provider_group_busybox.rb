$NetBSD$

--- lib/puppet/provider/group/busybox.rb.orig
+++ lib/puppet/provider/group/busybox.rb
@@ -0,0 +1,28 @@
+require 'puppet/provider/nameservice'
+require 'puppet/error'
+
+Puppet::Type.type(:group).provide :busybox, :parent => Puppet::Provider::NameService do
+  desc "Local group management for Busybox"
+
+  commands :busybox => "busybox"
+
+  def exists?
+    groups = []
+    Etc.send("setgrent")
+    begin
+      while ent = Etc.send("getgrent")
+        return true if ent.name == @resource[:name]
+      end
+    rescue
+      false
+    end
+  end
+
+  # lib/puppet/provider/nameservice/objectadd.rb#posixmethod
+  def posixmethod(name)
+    name = name.intern if name.is_a? String
+    method = self.class.option(name, :method) || name
+
+    method
+  end
+end
