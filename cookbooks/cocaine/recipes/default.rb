execute "apt-get update" do
  action :nothing
end.run_action(:run)

bash 'Turn on reverbrain repo' do
  code <<-EOH
cp -v /vagrant/chef/cocaine/files/default/repo.reverbrain.conf /etc/apt/sources.list.d/reverbrain.list

curl http://repo.reverbrain.com/REVERBRAIN.GPG | apt-key add -

apt-get update
  EOH
  notifies :run, 'execute[apt-get update]', :immediately
end.run_action(:run)

include_recipe 'poise-python'

node['cocaine']['packages'].each do |p,v|
  package p do
    version v
    options '--force-yes'
  end
end

node['cocaine']['pip_packages'].each do |p,v|
  python_package p do
    version v
  end
end

directory node['cocaine']['dir']

template "/etc/default/cocaine-runtime" do
  source "cocaine-runtime.erb"
  notifies :restart, 'service[cocaine-runtime]', :delayed
end

node['cocaine']['configs'].each do |name,params|
  file "/etc/cocaine/#{name}.conf" do
    content JSON.pretty_generate(node['cocaine']['configs'][name])
    notifies :restart, 'service[cocaine-runtime]', :delayed
  end
end

service "cocaine-runtime" do
  action [:enable, :start]
end

bash 'Creating cocaine app control objects' do
  code <<-EOH
  cocaine-tool runlist create --name default
  cocaine-tool profile upload --name default --profile='{"pool-limit": 4, "isolate": {"type": "process", "args": {"spool": "/var/spool/cocaine"}}}'
  EOH
end

bash 'Installing QR-code example' do
  cwd '/vagrant/cookbooks/cocaine/files/default/examples/qr'
  code 'cocaine-tool app upload && cocaine-tool app restart --name qr --profile default'
end

bash 'Bootstrapping' do
  cwd '/'
  code 'cocaine-tool proxy start --daemon --port=80'
end
