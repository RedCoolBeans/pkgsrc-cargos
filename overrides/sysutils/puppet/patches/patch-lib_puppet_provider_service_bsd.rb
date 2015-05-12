$NetBSD$

- drop OpenBSD as per git HEAD
- use @resource instead of @model to sync with changes made many years ago in other providers

--- lib/puppet/provider/service/bsd.rb.orig
+++ lib/puppet/provider/service/bsd.rb
@@ -1,13 +1,12 @@
-# Manage FreeBSD services.
 Puppet::Type.type(:service).provide :bsd, :parent => :init do
   desc <<-EOT
-    FreeBSD's (and probably NetBSD's?) form of `init`-style service management.
+    Generic BSD form of `init`-style service management with rc.d
 
     Uses `rc.conf.d` for service enabling and disabling.
 
   EOT
 
-  confine :operatingsystem => [:freebsd, :netbsd, :openbsd, :dragonfly]
+  confine :operatingsystem => [:freebsd, :netbsd, :dragonfly]
 
   def rcconf_dir
     '/etc/rc.conf.d'
@@ -19,13 +18,13 @@
 
   # remove service file from rc.conf.d to disable it
   def disable
-    rcfile = File.join(rcconf_dir, @model[:name])
+    rcfile = File.join(rcconf_dir, @resource[:name])
     File.delete(rcfile) if Puppet::FileSystem.exist?(rcfile)
   end
 
   # if the service file exists in rc.conf.d then it's already enabled
   def enabled?
-    rcfile = File.join(rcconf_dir, @model[:name])
+    rcfile = File.join(rcconf_dir, @resource[:name])
     return :true if Puppet::FileSystem.exist?(rcfile)
 
     :false
@@ -35,8 +34,10 @@
   # proper contents
   def enable
     Dir.mkdir(rcconf_dir) if not Puppet::FileSystem.exist?(rcconf_dir)
-    rcfile = File.join(rcconf_dir, @model[:name])
-    open(rcfile, 'w') { |f| f << "%s_enable=\"YES\"\n" % @model[:name] }
+    rcfile = File.join(rcconf_dir, @resource[:name])
+    File.open(rcfile, File::WRONLY | File::APPEND | File::CREAT, 0644) { |f|
+      f << "%s_enable=\"YES\"\n" % @resource[:name]
+    }
   end
 
   # Override stop/start commands to use one<cmd>'s and the avoid race condition
