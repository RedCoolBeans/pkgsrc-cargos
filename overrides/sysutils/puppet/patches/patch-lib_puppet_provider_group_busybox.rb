$NetBSD$

--- lib/puppet/provider/group/busybox.rb.orig
+++ lib/puppet/provider/group/busybox.rb
@@ -0,0 +1,43 @@
+require 'puppet/provider/nameservice'
+require 'puppet/error'
+
+Puppet::Type.type(:group).provide :busybox, :parent => Puppet::Provider::NameService do
+  desc "Local group management for Busybox"
+
+  commands :busybox => "busybox"
+  has_feature :system_groups
+
+  def create
+    debug "creating #{@resource[:name]}"
+    opts = []
+    opts += ["-g", @resource[:gid]] if @resource[:gid]
+    opts += ["-S"] if @resource[:system]
+
+    busybox(:addgroup, opts.flatten.compact, @resource[:name])
+  end
+
+  def delete
+    debug "deleting #{@resource[:name]}"
+    busybox(:delgroup, @resource[:name])
+  end
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
