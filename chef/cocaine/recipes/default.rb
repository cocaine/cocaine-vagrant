include_recipe 'python'

bash 'Turn on reverbrain repo' do
  code <<-EOH
cp -v /vagrant/chef/cocaine/repo.reverbrain.conf /etc/apt/sources.list.d/reverbrain.list

curl http://repo.reverbrain.com/REVERBRAIN.GPG | apt-key add -

apt-get update
  EOH
end

package 'libcocaine-core2' do
  options '--force-yes'
end

package 'cocaine-runtime' do
  options '--force-yes'
end

python_pip 'cocaine' do
  version '0.11.1.7'
  action :install
end

python_pip 'cocaine-tools' do
  version '0.11.6.1'
  action :install
end

bash 'Configuring cocaine-runtime and proxy' do
  cwd '/vagrant/examples'
  code <<-EOH
if [ ! -f /etc/cocaine/cocaine.conf ]; then
  mkdir -p /etc/cocaine
  cp /vagrant/examples/cocaine-tornado-proxy.conf /etc/cocaine/cocaine-tornado-proxy.conf

  cat <<EOF > /etc/default/cocaine-runtime
CONFIG_PATH="/etc/cocaine/cocaine.conf"
RUNTIME_PATH="/var/run/cocaine"
EOF

  cp /vagrant/cocaine.conf /etc/cocaine/cocaine.conf

  service cocaine-runtime restart
fi
  EOH
end

bash 'Creating cocaine app control objects' do
  code <<-EOH
  cocaine-tool runlist create --name default
  cocaine-tool profile upload --name default --profile='{"pool-limit": 4, "isolate": {"type": "process", "args": {"spool": "/var/spool/cocaine"}}}'
  EOH
end

python_pip 'pillow' do
  version '2.8.0'
end
python_pip 'qrcode'

bash 'Installing QR-code example' do
  cwd '/vagrant/examples/qr'
  code 'cocaine-tool app upload && cocaine-tool app restart --name qr --profile default'
end

bash 'Bootstrapping' do
  cwd '/'
  code 'cocaine-tool proxy start --daemon --port=80'
end
