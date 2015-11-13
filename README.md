# pkgsrc-cargos

CargOS specific pkgsrc packages and overrides

### Building packages
Become root then:
```sh
CARGOS_RELEASE=2015.11
pkgin -y in cargos-build-essential
mkdir -p /home/cargos && cd /home/cargos
git clone https://github.com/RedCoolBeans/pkgsrc-cargos.git pkgsrc
git checkout ${CARGOS_RELEASE}
cd /home/cargos/pkgsrc/cargos/docker-compose && bmake package-install
```
