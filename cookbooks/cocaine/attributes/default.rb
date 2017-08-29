default['cocaine']['packages'] = {
  'libcocaine-core2' => nil,
  'cocaine-runtime' => nil
}

default['cocaine']['pip_packages'] = {
 'cocaine' => '0.11.1.7',
 'cocaine-tools' => '0.11.6.1',
 'pillow' => '2.8.0',
 'qrcode' => nil
}

default['cocaine']['dir'] = '/etc/cocaine'
default['cocaine']['defaults']['CONFIG_PATH'] = '/etc/cocaine/cocaine.conf'
default['cocaine']['defaults']['RUNTIME_PATH'] = '/var/run/cocaine'


default['cocaine']['configs']['cocaine']['version'] = 2
default['cocaine']['configs']['cocaine']['paths']['plugins'] = '/usr/lib/cocaine'
default['cocaine']['configs']['cocaine']['paths']['runtime'] = '/var/run/cocaine'
default['cocaine']['configs']['cocaine']['services']['logging']['type'] = 'logging'
default['cocaine']['configs']['cocaine']['services']['storage']['type'] = 'storage'
default['cocaine']['configs']['cocaine']['services']['storage']['args']['backend'] = 'core'
default['cocaine']['configs']['cocaine']['services']['node']['type'] = 'node'
default['cocaine']['configs']['cocaine']['services']['node']['args']['runlist'] = 'default'
default['cocaine']['configs']['cocaine']['storages']['core']['type'] = 'files'
default['cocaine']['configs']['cocaine']['storages']['core']['args']['path'] = '/var/lib/cocaine'
default['cocaine']['configs']['cocaine']['loggers']['core']['type'] = 'syslog'
default['cocaine']['configs']['cocaine']['loggers']['core']['args']['identity'] = 'cocaine'
default['cocaine']['configs']['cocaine']['loggers']['core']['args']['verbosity'] = 'debug'

default['cocaine']['configs']['cocaine-tornado-proxy']['refresh_timeout'] = 100
default['cocaine']['configs']['cocaine-tornado-proxy']['timeouts']['qr'] = 1