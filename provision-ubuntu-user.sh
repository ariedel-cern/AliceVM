#!/bin/bash

ALICE="/home/vagrant/alice"

echo "Install alibuild"
pip install --user --upgrade alibuild

# install root standalone if needed
# pushd /vagrant
# update link for newest version
# wget "https://root.cern/download/root_v6.24.06.Linux-ubuntu20-x86_64-gcc9.3.tar.gz"
# tar xfv root_v6.24.04.Linux-ubuntu20-x86_64-gcc9.3.tar.gz
# rm root_v6.24.04.Linux-ubuntu20-x86_64-gcc9.3.tar.gz
# chown -R vagrant:vagrant root
# popd

# better run this interactively inside the machine
echo "setup AliPhysics"
mkdir -p $ALICE
pushd $ALICE
/home/vagrant/.local/bin/aliBuild init AliPhysics@master --defaults o2
# aliBuild build AliPhysics --defaults o2 --debug --always-prefer-system
popd

# better run this interactively inside the machine
echo "setup O2"
mkdir -p $ALICE
pushd $ALICE
/home/vagrant/.local/bin/aliBuild init O2Physics@master --defaults o2
# /home/vagrant/.local/bin/aliDoctor O2Physics --defaults o2 >O2Physics.log
# aliBuild build O2Physics --defaults o2 --debug --always-prefer-system
popd

exit 0
