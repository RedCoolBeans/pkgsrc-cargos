# pkgsrc-cargos

CargOS specific pkgsrc packages and overrides

### Hierarchy
* *localpatches/*  
Local patches that aren't part of pkgsrc.
* *overrides/*  
Overrides for pkgsrc (no CVS directories allowed!).  

### Building packages
Become root then:
```sh
PKGSRC_BRANCH=pkgsrc-2015Q1
pkgin -y in cargos-build-essential
mkdir -p /home/cargos && cd /home/cargos
cvs -d anoncvs@anoncvs.NetBSD.org:/cvsroot -q co -r ${PKGSRC_BRANCH} -P pkgsrc
cd pkgsrc && git clone https://github.com/RedCoolBeans/pkgsrc-cargos.git cargos
echo '.cvsignore' >/home/cargos/pkgsrc/.cvsignore
echo 'cargos' >>/home/cargos/pkgsrc/.cvsignore
for p in $(cd /home/cargos/pkgsrc/cargos/overrides && ls -d */*); do
	mount -o bind /home/cargos/pkgsrc/cargos/overrides/$p /home/cargos/pkgsrc/$p
done
cd /home/cargos/pkgsrc/net/jwhois && bmake package-install
```
