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
    alice.vm.box = "generic/ubuntu2004"
    # alice.ssh.forward_agent = true
    # alice.ssh.forward_x11 = true

    # libvirt setup
    alice.vm.provider :libvirt do |v|
      v.memory = 3072
      v.cpus = 4

      # network
      # alice.vm.network "private_network", ip: "192.168.121.31"
    end


    # share data between host and guest
    alice.vm.synced_folder "home", "/home/vagrant", type: "nfs", nfs_udp: false, nfs_version: 4

    # provisioning
    alice.vm.provision "shell", inline: <<-SHELL

      echo "Set Timezone"
      timedatectl set-timezon Europe/Berlin

      echo "update system"
      apt update
      apt upgrade -y

      echo "install prerequisites"
      apt install -y curl libcurl4-gnutls-dev build-essential gfortran libmysqlclient-dev xorg-dev libglu1-mesa-dev libfftw3-dev libxml2-dev git unzip autoconf automake autopoint texinfo gettext libtool libtool-bin pkg-config bison flex libperl-dev libbz2-dev swig liblzma-dev libnanomsg-dev rsync lsb-release environment-modules libglfw3-dev libtbb-dev python3-venv libncurses-dev software-properties-common cmake gsl-bin python3-dev python3-pip entr htop

      echo "install build tools"
      add-apt-repository ppa:neovim-ppa/unstable
      apt-get update
      apt install -y neovim clang-tools-12 clangd-12 clang-format-12 neovim python3-pynvim tmux tmuxp fzf ripgrep
      update-alternatives --install /usr/bin/clangd clangd /usr/bin/clangd-12 100
      update-alternatives --install /usr/bin/clang-format clang-format /usr/bin/clang-format-12 100
      # no apt packages unfortunately
      snap install shfmt bash-language-server


      echo "add ppa for alibuild"
      add-apt-repository ppa:alisw/ppa
      apt update

      echo "install alibuild"
      apt install -y python3-alibuild

      echo "clean up"
      apt autoremove -y
      apt autoclean -y

      # better run this interactively inside the machine
      # echo "setup aliroot"
      # mkdir alice
      # cd alice
      # aliBuild init AliPhysics@master
      # aliBuild build AliPhysics --defaults user-next-root6 --debug

    SHELL
  end
end
