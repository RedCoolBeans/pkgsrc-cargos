$NetBSD$

Recognize CargOS in order to set the following facts:
- operatingsystem
- operatingsystemmajrelease
- operatingsystemrelease
- os

--- lib/facter/operatingsystem/linux.rb.orig
+++ lib/facter/operatingsystem/linux.rb
@@ -50,6 +50,8 @@
           get_arista_release_with_release_file
         when "BlueWhite64"
           get_bluewhite_release_with_release_file
+        when "CargOS"
+          get_cargos_release_with_release_file
         when "CentOS", "RedHat", "Scientific", "SLC", "Ascendos", "CloudLinux", "PSBM",
              "XenServer", "Fedora", "MeeGo", "OracleLinux", "OEL", "oel", "OVS", "ovs"
           get_redhatish_release_with_release_file
@@ -242,6 +244,7 @@
         operatingsystem = nil
         release_files = {
           "AristaEOS"   => "/etc/Eos-release",
+          "CargOS"      => "/etc/cargos-release",
           "Debian"      => "/etc/debian_version",
           "Gentoo"      => "/etc/gentoo-release",
           "Fedora"      => "/etc/fedora-release",
@@ -375,6 +378,14 @@
             match[1] + "." + match[2]
           else
             "unknown"
+          end
+        end
+      end
+
+      def get_cargos_release_with_release_file
+        if release = Facter::Util::FileRead.read('/etc/cargos-release')
+          if match = /\d+\.\d+(:?\.\d+)?[A-M]?$/.match(release)
+            match[0]
           end
         end
       end
