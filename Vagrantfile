# File              : Vagrantfile
# Author            : Anton Riedel <anton.riedel@tum.de>
# Date              : 27.08.2021
# Last Modified Date: 27.08.2021
# Last Modified By  : Anton Riedel <anton.riedel@tum.de>
# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  # general setup
  config.vm.define "alice" do |alice|
    alice.vm.hostname = "alice"
    # alice.vm.box = "generic/ubuntu1804"
    alice.vm.box = "generic/ubuntu2004"

    # libvirt setup
    alice.vm.provider :libvirt do |v|
      v.memory = 4092
      # v.memory = 6144
      v.cpus = 4

    end

    # share data between host and guest
    alice.vm.synced_folder "home", "/home/vagrant", type: "nfs", nfs_udp: false, nfs_version: 4

    # provisioning
    alice.vm.provision "shell", inline: <<-SHELL
#!/bin/bash

echo "Set Timezone"
timedatectl set-timezone Europe/Berlin

echo "update system"
apt update
apt upgrade -y

# https://alice-doc.github.io/alice-analysis-tutorial/building/prereq-ubuntu.html
# with some additions
echo "install prerequisites"
apt install -y curl libcurl4-gnutls-dev build-essential gfortran libmysqlclient-dev xorg-dev libglu1-mesa-dev libfftw3-dev libxml2-dev git unzip autoconf automake autopoint texinfo gettext libtool libtool-bin pkg-config bison flex libperl-dev libbz2-dev swig liblzma-dev libnanomsg-dev rsync lsb-release environment-modules libglfw3-dev libtbb-dev python3-venv libncurses-dev software-properties-common cmake gsl-bin libgsl-dev python3-dev python3-pip libboost-all-dev libcgal-dev vc-dev libfastjet-dev libfastjet-fortran-dev libfastjetplugins-dev libfastjettools-dev gcc-10 g++-10 gfortran-10 clang-12 libclang-12-dev libuv1-dev libutf8proc-dev libfabric-dev libfabric-bin

echo "update symlinks to point to newest compiler version (at least for ubuntu 20.04)"
update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-10 100
update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-10 100
update-alternatives --install /usr/bin/gfortran gfortran /usr/bin/gfortran-10 100
update-alternatives --install /usr/bin/clang clang /usr/bin/clang-12 100
update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-12 100

echo "install build tools"
apt install -y clang-tools-12 clangd-12 clang-format-12 neovim python3-pynvim tmux tmuxp fzf ripgrep fd-find entr htop moreutils parallel
update-alternatives --install /usr/bin/clangd clangd /usr/bin/clangd-12 100
update-alternatives --install /usr/bin/clang-format clang-format /usr/bin/clang-format-12 100
# no apt packages available unfortunately
apt install -y snapd
snap install shfmt
snap install bash-language-server
# get updated cmake so we do not need to build it later
apt purge cmake
snap install cmake --classic
update-alternatives --install /usr/bin/cmake cmake /snap/bin/cmake 100

# best way to install alibuild
echo "add ppa for alibuild"
add-apt-repository ppa:alisw/ppa
apt update
echo "install alibuild"
apt install -y python3-alibuild

echo "clean up"
apt autoremove -y
apt autoclean -y

# install root standalone if needed
# pushd /home/vagrant
# update link for newest version
# wget "https://root.cern/download/root_v6.24.06.Linux-ubuntu20-x86_64-gcc9.3.tar.gz"
# tar xfv root_v6.24.04.Linux-ubuntu20-x86_64-gcc9.3.tar.gz
# rm root_v6.24.04.Linux-ubuntu20-x86_64-gcc9.3.tar.gz
# chown -R vagrant:vagrant root
# popd

# better run this interactively inside the machine
# echo "setup aliroot"
# mkdir /home/vagrant/alice
# pushd /home/vagrant/alice
# aliBuild init AliPhysics@master
# aliDoctor AliPhysics --defaults next-root6
# aliBuild build AliPhysics --defaults user-next-root6 --debug --always-prefer-system
# chown -R vagrant:vagrant /home/vagrant/alice
# popd

# better run this interactively inside the machine
# echo "setup O2"
# mkdir /home/vagrant/o2
# pushd /home/vagrant/o2
# aliBuild init O2@dev --defaults o2
# aliBuild init O2Physics@master --defaults o2
# aliDoctor O2Physics --defaults o2
# aliBuild build O2Physics --defaults o2 --debug --always-prefer-system
# chown -R vagrant:vagrant /home/vagrant/o2
# popd

exit 0
    SHELL
  end
end
