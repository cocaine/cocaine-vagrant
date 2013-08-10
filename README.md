# Overview

This project provides a mechanism to set up a Vagrant VM with the following Cocaine Cloud components:

* Cocaine Core
* Cocaine Runtime
* Cocaine Framework Python


## Requirements

* VirtualBox

* Vagrant
    - Download it from http://www.vagrantup.com (version 1.2 or higher)
    - Install required plugins:  
     `vagrant plugin install vagrant-berkshelf`  
     `vagrant plugin install vagrant-omnibus`
     
* Ruby 1.9.3


## Installation

```
git clone https://github.com/3Hren/cocaine-vagrant-installer.git
cd cocaine-vagrant-installer
vagrant up
```


## Running Cocaine Cloud

* shell into the VM if you are not already there

```
:~$ vagrant ssh
```


## Test Your Cocaine Cloud Instance

```
:~$ cocaine-tool info
{}
```
