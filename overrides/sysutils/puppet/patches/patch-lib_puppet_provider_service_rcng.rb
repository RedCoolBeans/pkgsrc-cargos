$NetBSD$

New provider for RCng which uses the correct content to enable a service and prevent
"/etc/rc.d/docker: WARNING: $docker is not set properly - see rc.conf(5)."

--- lib/puppet/provider/service/rcng.rb.orig
+++ lib/puppet/provider/service/rcng.rb
@@ -0,0 +1,42 @@
+Puppet::Type.type(:service).provide :rcng, :parent => :bsd do
+  desc <<-EOT
+    RCng service management with rc.d
+  EOT
+
+  defaultfor :operatingsystem => [:netbsd, :cargos]
+
+  def self.defpath
+    "/etc/rc.d"
+  end
+
+  # if the service file exists in rc.conf.d AND matches an expected pattern
+  # then it's already enabled
+  def enabled?
+    rcfile = File.join(rcconf_dir, @resource[:name])
+    if Puppet::FileSystem.exist?(rcfile)
+      File.open(rcfile).readlines.each do |line|
+        # Now look for something that looks like "service=${service:=YES}" or "service=YES"
+        if matchdata = line.match(/^#{@resource[:name]}=(?:YES|\${#{@resource[:name]}:=YES})/)
+          return :true
+        end
+      end
+    end
+
+    :false
+  end
+
+  # enable service by creating a service file under rc.conf.d with the
+  # proper contents, or by modifying it's contents to to enable the service.
+  def enable
+    debug "Enabling"
+    Dir.mkdir(rcconf_dir) if not Puppet::FileSystem.exist?(rcconf_dir)
+    rcfile = File.join(rcconf_dir, @resource[:name])
+    if Puppet::FileSystem.exist?(rcfile)
+      fail("#{rcfile} exists, cowardly refusing to overwrite until #enable is adjusted")
+    else
+      File.open(rcfile, File::WRONLY | File::CREAT, 0644) { |f|
+        f << "%s=${%s:=YES}\n" % [@resource[:name], @resource[:name]]
+      }
+    end
+  end
+end
