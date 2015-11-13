/usr/include/features.h:148:3: error: #warning "_BSD_SOURCE and _SVID_SOURCE are deprecated, use _DEFAULT_SOURCE" [-Werror=cpp]
 # warning "_BSD_SOURCE and _SVID_SOURCE are deprecated, use _DEFAULT_SOURCE"

--- grub-core/kern/emu/hostfs.c.orig
+++ grub-core/kern/emu/hostfs.c
@@ -16,7 +16,7 @@
  *  You should have received a copy of the GNU General Public License
  *  along with GRUB.  If not, see <http://www.gnu.org/licenses/>.
  */
-#define _BSD_SOURCE
+#define _DEFAULT_SOURCE
 #include <grub/fs.h>
 #include <grub/file.h>
 #include <grub/disk.h>
