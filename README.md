# pkgsrc-cargos

CargOS specific pkgsrc packages and overrides

### Hierarchy
* *localpatches/ *  
Local patches that aren't part of pkgsrc.
* *overrides/*  
Overrides for pkgsrc (no CVS directories allowed!).  
* *scripts/*  
CargOS release engineering scripts.

### Building packages
Become root then:
```sh
PKGSRC_BRANCH=pkgsrc-2014Q4
pkgin -y in cargos-build-essential
mkdir -p /home/cargos && cd /home/cargos
cvs -d anoncvs@anoncvs.NetBSD.org:/cvsroot -q co -r ${PKGSRC_BRANCH} -P pkgsrc
cd pkgsrc && git clone ssh://gitolite3@cwdev.loginto.me:2222/pkgsrc-cargos.git cargos
echo '.cvsignore' >/home/cargos/pkgsrc/.cvsignore
echo 'cargos' >>/home/cargos/pkgsrc/.cvsignore
/bin/bash ./scripts/overrides.sh
```

##### pkgsrc-2014Q4
This branches needs some update from HEAD (until pkgsrc-2015Q1 is tagged) due to the following:
* pkgtools/pkgin (needs support for upgrading PRESERVE packages)  
* security/netpgpverify (needed by patched pkg_install from Joyent)
* security/openssh (fixed rc.d script)  
* textproc/mdocml (support for a DB-less man(1))  

```sh
for i in pkgtools/pkgin security/openssh textproc/mdocml; do \
	cd /home/cargos/pkgsrc/$i && cvs -up -PAd
done
```

