# File              : Vagrantfile
# Author            : Anton Riedel <anton.riedel@tum.de>
# Date              : 27.08.2021
# Last Modified Date: 09.09.2022
# Last Modified By  : Anton Riedel <anton.riedel@tum.de>
# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  # general setup
  config.vm.define "alice" do |alice|
    alice.vm.hostname = "alice"
    alice.vm.box = "generic/ubuntu2204"

    # libvirt setup
    alice.vm.provider :libvirt do |v|
      v.memory = 26624 # 26*1024
      v.cpus = 16
    end
    # share data between host and guest
    alice.vm.synced_folder "vagrant", "/vagrant", type: "nfs", nfs_udp: false, nfs_version: 4
    
  end
  config.vm.provision "ansible" do |ansible|
    ansible.playbook = "provision/bootstrap.yml"
  end

end
