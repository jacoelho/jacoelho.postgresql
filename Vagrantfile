# -*- mode: ruby -*-
# vi: set ft=ruby :

RAM = 389
NUMBER_SLAVES = 1

Vagrant.configure(2) do |config|
  config.vm.box = "boxcutter/ubuntu1404"

  config.vm.provider :virtualbox do |v|
    v.check_guest_additions = false
    v.customize ["modifyvm", :id, "--cpus", "1", "--memory", RAM]
  end

  # master
  config.vm.define :master do |master|
    master.vm.hostname = "master"
    master.vm.network "private_network", ip: "10.0.0.100"
  end

  NUMBER_SLAVES.times do |i|
    slave_id = "slave-#{i + 1}"
    config.vm.define slave_id do |slave|
      slave.vm.hostname = slave_id
      slave.vm.network "private_network", ip: "10.0.0.#{10 + i}"
    end
  end

  config.vm.provision "ansible" do |ansible|
    ansible.playbook = "tests/playbook.yml"
    ansible.verbose = "vvvv"
    ansible.extra_vars = {
      master_ip: "10.0.0.100",
      pg_user: "replicator",
      pg_password: "password"
    }
  end
end
