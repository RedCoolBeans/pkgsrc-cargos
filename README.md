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
PKGSRC_BRANCH=pkgsrc-2014Q4
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

##### pkgsrc-2014Q4
This branches needs some update from pkgsrc-2015Q1 due to the following:
* pkgtools/pkgin (needs support for upgrading PRESERVE packages)  
* security/netpgpverify (needed by patched pkg_install from Joyent)
* sysutils/file (CVE-2014-9620)
* textproc/mdocml (support for a DB-less man(1))  

```sh
for i in pkgtools/pkgin security/netpgpverify sysutils/file textproc/mdocml; do \
	cd /home/cargos/pkgsrc/$i && cvs -q up -rpkgsrc-2015Q1 -PAd
done
```

