--- readconf.c.orig
+++ readconf.c
@@ -1660,7 +1660,7 @@
 	options->tun_remote = -1;
 	options->local_command = NULL;
 	options->permit_local_command = -1;
-	options->use_roaming = -1;
+	options->use_roaming = 0;
 	options->visual_host_key = -1;
 	options->ip_qos_interactive = -1;
 	options->ip_qos_bulk = -1;
@@ -1833,8 +1833,7 @@
 		options->tun_remote = SSH_TUNID_ANY;
 	if (options->permit_local_command == -1)
 		options->permit_local_command = 0;
-	if (options->use_roaming == -1)
-		options->use_roaming = 1;
+	options->use_roaming = 0;
 	if (options->visual_host_key == -1)
 		options->visual_host_key = 0;
 	if (options->ip_qos_interactive == -1)
