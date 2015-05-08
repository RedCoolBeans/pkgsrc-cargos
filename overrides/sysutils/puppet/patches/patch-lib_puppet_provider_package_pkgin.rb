$NetBSD$

- Make 'pkgin' the default provider for CargOS
- 'pkgin list' format changed (package-version;descr)
- Always pass '-p' to 'pkgin list' so we know we'll always the expected format
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
+    match, name, version, status = *package.match(/(\S+)-(\S+?);(?:(=|>|<))?.+$/)
     if match
       {
         :name     => name,
@@ -30,7 +30,7 @@
   end
 
   def self.instances
-    pkgin(:list).split("\n").map do |package|
+    pkgin("-p", :list).split("\n").map do |package|
       new(parse_pkgin_line(package))
     end
   end
@@ -51,7 +51,7 @@
   end
 
   def parse_pkgsearch_line
-    packages = pkgin(:search, resource[:name]).split("\n")
+    packages = pkgin("-p", :search, resource[:name]).split("\n")
 
     return [] if packages.length == 1
 
@@ -75,7 +75,7 @@
   end
 
   def latest
-    package = parse_pkgsearch_line.detect{ |package| package[:status] == '<' }
+    package = parse_pkgsearch_line.detect{ |p| p[:status] == '<' }
     return properties[:ensure] if not package
     return package[:ensure]
   end
