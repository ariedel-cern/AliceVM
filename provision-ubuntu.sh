#!/bin/bash

echo "Set Timezone"
timedatectl set-timezone Europe/Berlin

echo "update system"
apt update
apt upgrade -y

# https://alice-doc.github.io/alice-analysis-tutorial/building/prereq-ubuntu.html
# with some additions
echo "install prerequisites"
apt install -y curl libcurl4-gnutls-dev build-essential gfortran libmysqlclient-dev xorg-dev libglu1-mesa-dev libfftw3-dev libxml2-dev git unzip autoconf automake autopoint texinfo gettext libtool libtool-bin pkg-config bison flex libperl-dev libbz2-dev swig liblzma-dev libnanomsg-dev rsync lsb-release environment-modules libglfw3-dev libtbb-dev python3-dev python3-venv python3-pip python3-pkginfo libncurses-dev software-properties-common libgsl-dev liblz4-dev libutf8proc-dev libsqlite3-dev python-is-python3

echo "update symlinks to point to newest compiler version (at least for ubuntu 20.04)"
apt install -y gcc-10 g++-10 gfortran-10
update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-10 100
update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-10 100
update-alternatives --install /usr/bin/gfortran gfortran /usr/bin/gfortran-10 100

echo "install build tools"
apt install -y clang-tools-12 clangd-12 clang-format-12 tmux tmuxp fzf ripgrep fd-find entr htop moreutils parallel neovim
update-alternatives --install /usr/bin/clangd clangd /usr/bin/clangd-12 100
update-alternatives --install /usr/bin/clang-format clang-format /usr/bin/clang-format-12 100

# no apt packages available unfortunately
apt install -y snapd
# get updated cmake so we do not need to build it later
apt purge -y cmake
snap install cmake --classic
update-alternatives --install /usr/bin/cmake cmake /snap/bin/cmake 100

# currently broken, install via pip
# best way to install alibuild
# echo "add ppa for alibuild"
# add-apt-repository ppa:alisw/ppa
# apt update
# echo "install alibuild"
# apt install -y python3-alibuild

echo "clean up"
apt autoremove -y
apt autoclean -y

exit 0
