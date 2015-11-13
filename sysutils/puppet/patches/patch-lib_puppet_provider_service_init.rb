$NetBSD$

- add RCng specific excludes

--- lib/puppet/provider/service/init.rb.orig
+++ lib/puppet/provider/service/init.rb
@@ -55,6 +55,9 @@
     excludes += %w{cryptdisks-udev}
     excludes += %w{statd-mounting}
     excludes += %w{gssd-mounting}
+    # Prevent Puppet from failing to get status of these meta-services which
+    # don't actually start a service, but serve as a dependency placeholder.
+    excludes += %w{DAEMON DISKS LOGIN NETWORKING SERVERS}
   end
 
   # List all services of this type.
