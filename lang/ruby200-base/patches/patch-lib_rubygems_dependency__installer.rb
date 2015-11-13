$NetBSD: patch-lib_rubygems_dependency__installer.rb,v 1.3 2014/02/19 15:52:05 taca Exp $

* Add install_root option for pkgsrc's rubygems support.

--- lib/rubygems/dependency_installer.rb.orig	2013-11-13 02:59:08.000000000 +0000
+++ lib/rubygems/dependency_installer.rb
@@ -50,6 +50,7 @@ class Gem::DependencyInstaller
   # :format_executable:: See Gem::Installer#initialize.
   # :ignore_dependencies:: Don't install any dependencies.
   # :install_dir:: See Gem::Installer#install.
+  # :install_root:: See Gem::Installer#install.
   # :prerelease:: Allow prerelease versions.  See #install.
   # :security_policy:: See Gem::Installer::new and Gem::Security.
   # :user_install:: See Gem::Installer.new
@@ -57,12 +58,14 @@ class Gem::DependencyInstaller
   # :build_args:: See Gem::Installer::new
 
   def initialize(options = {})
-    @install_dir = options[:install_dir] || Gem.dir
-
     if options[:install_dir] then
+      @install_dir = options[:install_dir]
+
       # HACK shouldn't change the global settings, needed for -i behavior
       # maybe move to the install command?  See also github #442
       Gem::Specification.dirs = @install_dir
+    else
+      @install_dir = Gem.dir
     end
 
     options = DEFAULT_OPTIONS.merge options
@@ -91,7 +94,12 @@ class Gem::DependencyInstaller
     @installed_gems = []
     @toplevel_specs = nil
 
-    @cache_dir = options[:cache_dir] || @install_dir
+    @install_root = options[:install_root] || ""
+    install_dir = @install_dir
+    unless @install_root.nil? or @install_root.empty?
+      install_dir = File.join(@install_root, install_dir)
+    end
+    @cache_dir = options[:cache_dir] || install_dir
 
     # Set with any errors that SpecFetcher finds while search through
     # gemspecs for a dep
@@ -371,6 +379,7 @@ class Gem::DependencyInstaller
                                 :format_executable   => @format_executable,
                                 :ignore_dependencies => @ignore_dependencies,
                                 :install_dir         => @install_dir,
+                                :install_root        => @install_root,
                                 :security_policy     => @security_policy,
                                 :user_install        => @user_install,
                                 :wrappers            => @wrappers,
