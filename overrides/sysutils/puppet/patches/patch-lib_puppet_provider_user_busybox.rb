$NetBSD$

--- lib/puppet/provider/user/busybox.rb.orig
+++ lib/puppet/provider/user/busybox.rb
@@ -0,0 +1,55 @@
+require 'puppet/provider/nameservice'
+require 'puppet/error'
+
+Puppet::Type.type(:user).provide :busybox, :parent => Puppet::Provider::NameService do
+  desc "Local user management for Busybox"
+
+  commands :busybox => "busybox"
+
+  def create
+    debug "creating #{@resource[:name]}"
+    busybox(:adduser, "-D", @resource[:name])
+  end
+
+  def delete
+    debug "deleting #{@resource[:name]}"
+    busybox(:deluser, @resource[:name])
+  end
+
+  def exists?
+    begin
+      Etc.getpwnam(@resource[:name])
+    rescue
+      false
+    end
+  end
+
+  def home
+    self.getpwnam(:dir)
+  end
+
+  def uid
+    self.getpwnam(:uid)
+  end
+
+  def gid
+    self.getpwnam(:gid)
+  end
+
+  # XXXTODO
+  def comment
+  end
+
+  # XXXTODO
+  def groups
+  end
+
+  def getpwnam(field)
+    begin
+      entry = Etc.getpwnam(@resource[:name])
+      entry[field] if entry.respond_to?(field)
+    rescue
+      return
+    end
+  end
+end
