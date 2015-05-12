$NetBSD$

New provider for RCng which uses the correct content to enable a service and prevent
"/etc/rc.d/docker: WARNING: $docker is not set properly - see rc.conf(5)."

--- lib/puppet/provider/service/rcng.rb.orig
+++ lib/puppet/provider/service/rcng.rb
@@ -0,0 +1,20 @@
+Puppet::Type.type(:service).provide :rcng, :parent => :bsd do
+  desc <<-EOT
+    RCng service management with rc.d
+  EOT
+
+  confine :operatingsystem => [:netbsd, :cargos]
+
+  def self.defpath
+    "/etc/rc.d"
+  end
+
+  # enable service by creating a service file under rc.conf.d with the
+  # proper contents
+  def enable
+    debug "Enabling"
+    Dir.mkdir(rcconf_dir) if not Puppet::FileSystem.exist?(rcconf_dir)
+    rcfile = File.join(rcconf_dir, @resource[:name])
+    open(rcfile, 'w') { |f| f << "%s=${%s:=YES}\n" % [@resource[:name], @resource[:name]] }
+  end
+end
