# Overview

This project provides a mechanism to set up a Vagrant VM with the following Cocaine Cloud components:

* Cocaine Core
* Cocaine Runtime
* Cocaine Framework Python (with embedded cocaine proxy)


## Requirements

* VirtualBox

* Vagrant
    - Download it from http://www.vagrantup.com (version 1.5.4 or higher)
    - Install required plugins:  
     `vagrant plugin install vagrant-omnibus`    
     `vagrant plugin install vagrant-berkshelf --plugin-version '>= 2.0.1'`
     
* Ruby 1.9.3


## Installation

```
git clone https://github.com/cocaine/cocaine-vagrant.git
cd cocaine-vagrant
vagrant up
```


## Running Cocaine Cloud

* shell into the VM if you are not already there

```
vagrant ssh
```


## Test Your Cocaine Cloud Instance
At this point, there is one application running - QR-code generator. To be sure, that it is running, type:
```
cocaine-tool info
```

The answer will be (approximately):
```
{
    "apps": {
        "qr": {
            "load-median": 0, 
            "profile": "default", 
            "sessions": {
                "pending": 0
            }, 
            "queue": {
                "depth": 0, 
                "capacity": 100
            }, 
            "state": "running", 
            "slaves": {
                "active": 0, 
                "idle": 1, 
                "capacity": 4
            }
        }
    }
}
```

In this example we provide embedded http proxy for Cocaine applications. Check if it is running:
```
sudo cocaine-tool proxy status
```

If the answer is something like `Running: 4893` (pid number may vary) that's ok.

Finally, open your browser at your wish and type:
```
http://localhost:48080/qr/generate/?message=Hello,%20cocaine%20world!
```

The cloud application shows answer to you.
