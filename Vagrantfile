# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  # Offizielle Rocky Linux 9 Box
  config.vm.box = "rockylinux/9"
  config.vm.hostname = "rocky-soc-node"

  # Feste IP im lokalen VirtualBox Host-Only Netzwerk (muss zu deiner hosts.ini passen)
  config.vm.network "private_network", ip: "192.168.56.50"

  config.vm.provider "virtualbox" do |vb|
    vb.name = "rocky-soc-node"
    vb.memory = "2048"
    vb.cpus = 2
  end
end
