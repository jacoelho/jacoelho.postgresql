# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = "box-cutter/ubuntu1404"
  config.vm.network "private_network", ip: "192.168.33.10"

  config.vm.provider "virtualbox" do |vb|
    vb.memory = "389"
  end

  config.vm.provision "ansible" do |ansible|
    ansible.playbook = "tests/playbook.yml"
    ansible.verbose = "vvvv"
  end
end
