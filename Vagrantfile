# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.require_version ">= 1.5.4"

Vagrant.configure("2") do |config|
  config.omnibus.chef_version = "11.6.0"

  config.vm.define "cocaine-install"

  # plain precise64 box with kernel upgraded to 3.8
  # and GRUB_CMDLINE_LINUX="cgroup_enable=memory swapaccount=1"
  config.vm.box = "precise64-docker"
  config.vm.box_url = "http://repo.reverbrain.com/vagrant-base/precise64-docker.box"

#  config.vm.network :forwarded_port, guest: 80, host: 48080
  config.vm.network "private_network", ip: "10.11.12.13"
  
  config.berkshelf.enabled = true

  config.vm.provider "virtualbox" do |v|
    v.memory = 1024
  end
  
  config.vm.provision :chef_solo do |chef|
    chef.add_recipe 'apt::default'
    chef.add_recipe 'git'
    chef.add_recipe 'python'
    chef.add_recipe 'cocaine'
  end
end

