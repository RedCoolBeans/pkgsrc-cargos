$NetBSD$

--- lib/puppet/provider/user/busybox.rb.orig
+++ lib/puppet/provider/user/busybox.rb
@@ -0,0 +1,98 @@
+require 'puppet/provider/nameservice'
+require 'puppet/error'
+require 'open3'
+
+Puppet::Type.type(:user).provide :busybox, :parent => Puppet::Provider::NameService do
+  desc "Local user management for Busybox"
+
+  commands :busybox => "busybox"
+  # :manages_passwords requires Busybox to be compiled with FEATURE_SHADOWPASSWDS
+  has_features :manages_shell, :system_users, :manages_passwords
+
+  options :password, :method => :sp_pwdp
+
+  def create
+    debug "creating #{@resource[:name]}"
+    opts = ["-D"]
+    opts += ["-h", @resource[:home]] if @resource[:home]
+    opts += ["-S"] if @resource[:system]
+    opts += ["-u", @resource[:uid]] if @resource[:uid]
+    opts += ["-s", @resource[:shell]] if @resource[:shell]
+    opts += ["-g", @resource[:comment]] if @resource[:comment]
+
+    busybox(:adduser, opts.flatten.compact, @resource[:name])
+
+    # Now set the password if needed
+    self.password = @resource[:password] if @resource[:password]
+  end
+
+  def delete
+    debug "deleting #{@resource[:name]}"
+    busybox(:deluser, @resource[:name])
+  end
+
+  def password=(pwhash)
+    # XXX: Feels like a hack but Shadow::Passwd.sgetspent() is unusable for it crashes:
+    # *** Error in `irb': free(): invalid pointer: 0x00007fc9103b2be0 ***
+    # Once ruby-shadow works we can also enable password expiration.
+    stdin, stdout, stderr = Open3.popen3("echo \"#{resource[:name]}:#{resource[:password]}\" | chpasswd -e")
+    stdin.close
+  end
+
+  [:password].each do |shadow_property|
+    define_method(shadow_property) do
+      if Puppet.features.libshadow?
+        if ent = Shadow::Passwd.getspnam(@resource.name)
+          method = self.class.option(shadow_property, :method)
+          return unmunge(shadow_property, ent.send(method))
+        end
+      end
+      :absent
+    end
+  end
+
+  def exists?
+    begin
+      !!Etc.getpwnam(@resource[:name])
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
+
+  # lib/puppet/provider/nameservice/objectadd.rb#posixmethod
+  def posixmethod(name)
+    name = name.intern if name.is_a? String
+    method = self.class.option(name, :method) || name
+
+    method
+  end
+end
