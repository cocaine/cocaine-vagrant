# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = '2'

Vagrant.require_version '>= 1.5.4'

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.omnibus.chef_version = '11.6.0'

  config.vm.define 'cocaine-install'

  config.vm.box = 'precise64-docker'
  config.vm.box_url = 'https://github.com/cocaine/cocaine-vagrant/releases/download/v0.11/precise64-docker.box'

  config.vm.network :forwarded_port, guest: 80, host: 48080

  config.berkshelf.enabled = true

  config.vm.provider "virtualbox" do |v|
    v.memory = 1024
  end

  config.vm.provision :chef_solo do |chef|
    chef.add_recipe 'apt::default'
    chef.add_recipe 'python'
    chef.add_recipe 'cocaine'
  end
end

