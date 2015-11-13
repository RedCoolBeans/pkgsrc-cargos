$NetBSD$

- Make 'pkgin' the default provider for CargOS
- https://github.com/puppetlabs/puppet/pull/3905
- Upstream backport:
From 9cd470a0df890d5f7f097fd9f3aa3ecd82390066 Mon Sep 17 00:00:00 2001
From: Kylo Ginsberg <kylo@puppetlabs.com>
Date: Mon, 15 Dec 2014 09:18:07 -0800
Subject: [PATCH] (maint) Enable rubocop checking for shadowed variables

--- lib/puppet/provider/package/pkgin.rb.orig
+++ lib/puppet/provider/package/pkgin.rb
@@ -5,15 +5,15 @@
 
   commands :pkgin => "pkgin"
 
-  defaultfor :operatingsystem => [ :dragonfly , :smartos ]
+  defaultfor :operatingsystem => [ :dragonfly , :smartos, :cargos ]
 
   has_feature :installable, :uninstallable, :upgradeable, :versionable
 
   def self.parse_pkgin_line(package)
 
     # e.g.
-    #   vim-7.2.446 =        Vim editor (vi clone) without GUI
-    match, name, version, status = *package.match(/(\S+)-(\S+)(?: (=|>|<))?\s+.+$/)
+    #   vim-7.2.446;Vim editor (vi clone) without GUI
+    match, name, version, status = *package.match(/([^\s\-]+)-([^;\s]+)[;\s](=|>|<)?.+$/)
     if match
       {
         :name     => name,
@@ -75,7 +75,7 @@
   end
 
   def latest
-    package = parse_pkgsearch_line.detect{ |package| package[:status] == '<' }
+    package = parse_pkgsearch_line.detect{ |p| p[:status] == '<' }
     return properties[:ensure] if not package
     return package[:ensure]
   end
