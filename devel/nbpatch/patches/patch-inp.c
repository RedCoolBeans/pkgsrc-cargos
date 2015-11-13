$NetBSD$

--- inp.c.orig
+++ inp.c
@@ -39,8 +39,10 @@
 #include <sys/file.h>
 #include <sys/stat.h>
 #include <sys/mman.h>
+#include <sys/wait.h>
 
 #include <ctype.h>
+#include <errno.h>
 #include <fcntl.h>
 #include <libgen.h>
 #include <limits.h>
@@ -147,12 +149,14 @@
 static bool
 plan_a(const char *filename)
 {
-	int		ifd, statfailed;
+	int		ifd, statfailed, devnull, pstat;
 	char		*p, *s, lbuf[MAXLINELEN];
 	struct stat	filestat;
 	off_t		i;
 	ptrdiff_t	sz;
 	size_t		iline, lines_allocated;
+	pid_t		pid;
+	char		*argp[4] = {NULL};
 
 #ifdef DEBUGGING
 	if (debug & 8)
@@ -180,13 +184,14 @@
 	}
 	if (statfailed && check_only)
 		fatal("%s not found, -C mode, can't probe further\n", filename);
-	/* For nonexistent or read-only files, look for RCS or SCCS versions.  */
+	/* For nonexistent or read-only files, look for RCS versions.  */
+
 	if (statfailed ||
 	    /* No one can write to it.  */
 	    (filestat.st_mode & 0222) == 0 ||
 	    /* I can't write to it.  */
 	    ((filestat.st_mode & 0022) == 0 && filestat.st_uid != getuid())) {
-		const char	*cs = NULL, *filebase, *filedir;
+		char	*filebase, *filedir;
 		struct stat	cstat;
 		char *tmp_filename1, *tmp_filename2;
 
@@ -197,40 +202,22 @@
 		filebase = basename(tmp_filename1);
 		filedir = dirname(tmp_filename2);
 
-		/* Leave room in lbuf for the diff command.  */
-		s = lbuf + 20;
-
 #define try(f, a1, a2, a3) \
-	(snprintf(s, sizeof lbuf - 20, f, a1, a2, a3), stat(s, &cstat) == 0)
+	(snprintf(lbuf, sizeof lbuf, f, a1, a2, a3), stat(lbuf, &cstat) == 0)
 
-		if (try("%s/RCS/%s%s", filedir, filebase, RCSSUFFIX) ||
-		    try("%s/RCS/%s%s", filedir, filebase, "") ||
-		    try("%s/%s%s", filedir, filebase, RCSSUFFIX)) {
-			snprintf(buf, buf_len, CHECKOUT, filename);
-			snprintf(lbuf, sizeof lbuf, RCSDIFF, filename);
-			cs = "RCS";
-		} else if (try("%s/SCCS/%s%s", filedir, SCCSPREFIX, filebase) ||
-		    try("%s/%s%s", filedir, SCCSPREFIX, filebase)) {
-			snprintf(buf, buf_len, GET, s);
-			snprintf(lbuf, sizeof lbuf, SCCSDIFF, s, filename);
-			cs = "SCCS";
-		} else if (statfailed)
-			fatal("can't find %s\n", filename);
-
-		free(tmp_filename1);
-		free(tmp_filename2);
-
 		/*
 		 * else we can't write to it but it's not under a version
 		 * control system, so just proceed.
 		 */
-		if (cs) {
+		if (try("%s/RCS/%s%s", filedir, filebase, RCSSUFFIX) ||
+		    try("%s/RCS/%s%s", filedir, filebase, "") ||
+		    try("%s/%s%s", filedir, filebase, RCSSUFFIX)) {
 			if (!statfailed) {
 				if ((filestat.st_mode & 0222) != 0)
 					/* The owner can write to it.  */
 					fatal("file %s seems to be locked "
-					    "by somebody else under %s\n",
-					    filename, cs);
+					    "by somebody else under RCS\n",
+					    filename);
 				/*
 				 * It might be checked out unlocked.  See if
 				 * it's safe to check out the default version
@@ -238,21 +225,59 @@
 				 */
 				if (verbose)
 					say("Comparing file %s to default "
-					    "%s version...\n",
-					    filename, cs);
-				if (system(lbuf))
+					    "RCS version...\n", filename);
+
+				switch (pid = fork()) {
+				case -1:
+					fatal("can't fork: %s\n",
+					    strerror(errno));
+				case 0:
+					devnull = open("/dev/null", O_RDONLY);
+					if (devnull == -1) {
+						fatal("can't open /dev/null: %s",
+						    strerror(errno));
+					}
+					(void)dup2(devnull, STDOUT_FILENO);
+					argp[0] = strdup(RCSDIFF);
+					argp[1] = strdup(filename);
+					execv(RCSDIFF, argp);
+					exit(127);
+				}
+				pid = waitpid(pid, &pstat, 0);
+				if (pid == -1 || WEXITSTATUS(pstat) != 0) {
 					fatal("can't check out file %s: "
-					    "differs from default %s version\n",
-					    filename, cs);
+					    "differs from default RCS version\n",
+					    filename);
+				}
 			}
+
 			if (verbose)
-				say("Checking out file %s from %s...\n",
-				    filename, cs);
-			if (system(buf) || stat(filename, &filestat))
-				fatal("can't check out file %s from %s\n",
-				    filename, cs);
+				say("Checking out file %s from RCS...\n",
+				    filename);
+
+			switch (pid = fork()) {
+			case -1:
+				fatal("can't fork: %s\n", strerror(errno));
+			case 0:
+				argp[0] = strdup(CHECKOUT);
+				argp[1] = strdup("-l");
+				argp[2] = strdup(filename);
+				execv(CHECKOUT, argp);
+				exit(127);
+			}
+			pid = waitpid(pid, &pstat, 0);
+			if (pid == -1 || WEXITSTATUS(pstat) != 0 ||
+			    stat(filename, &filestat)) {
+				fatal("can't check out file %s from RCS\n",
+				    filename);
+			}
+		} else if (statfailed) {
+			fatal("can't find %s\n", filename);
 		}
+		free(tmp_filename1);
+		free(tmp_filename2);
 	}
+
 	filemode = filestat.st_mode;
 	if (!S_ISREG(filemode))
 		fatal("%s is not a normal file--can't patch\n", filename);
