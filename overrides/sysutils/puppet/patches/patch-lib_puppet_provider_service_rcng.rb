$NetBSD$

New provider for RCng which uses the correct content to enable a service and prevent
"/etc/rc.d/docker: WARNING: $docker is not set properly - see rc.conf(5)."

--- lib/puppet/provider/service/rcng.rb.orig
+++ lib/puppet/provider/service/rcng.rb
@@ -0,0 +1,51 @@
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
+        if line.match(/^\s*#{@resource[:name]}=(?:YES|\${#{@resource[:name]}:=YES})/)
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
+      newcontents = []
+      File.open(rcfile).readlines.each do |line|
+        if line.match(/^\s*#{@resource[:name]}=(NO|\$\{#{@resource[:name]}:NO\})/)
+          line = "#{@resource[:name]}=${#{@resource[:name]}:=YES}"
+        end
+        newcontents.push(line)
+      end
+      Puppet::Util.replace_file(rcfile, 0644) do |f|
+        f.puts newcontents
+      end
+    else
+      Puppet::Util.replace_file(rcfile, 0644) do |f|
+        f.puts "%s=${%s:=YES}\n" % [@resource[:name], @resource[:name]]
+      end
+    end
+  end
+end
