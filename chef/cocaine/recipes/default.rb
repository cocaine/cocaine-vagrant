
include_recipe "python"

package "curl"

bash "Turn on reverbrain repo" do
  code <<-EOH
cp -v /vagrant/chef/cocaine/repo.reverbrain.conf /etc/apt/sources.list.d/reverbrain.list

curl http://repo.reverbrain.com/REVERBRAIN.GPG | apt-key add -

apt-get update
EOH
end

package "g++"
package "python-dev"

bash "cocaine packages" do
  code <<-EOH
apt-get install -y\
  libcocaine-core2 \
  cocaine-runtime \
  cocaine-framework-native \
  libcocaine-plugin-chrono2 \
  libcocaine-plugin-cache2 \
  libcocaine-plugin-docker2 \
  libcocaine-dev
EOH
end

python_pip "cocaine"
python_pip "cocaine-tools"

bash "install docker" do
  creates "/etc/docker.chef.done"
  user "root"
  cwd "/"
  code <<-EOH
# Add the repository to your APT sources
echo deb http://get.docker.io/ubuntu docker main > /etc/apt/sources.list.d/docker.list
# Then import the repository key
curl http://get.docker.io/gpg | apt-key add -
# Install docker
apt-get update ; apt-get install -y lxc-docker
usermod -aG docker vagrant
usermod -aG docker cocaine

touch /etc/docker.chef.done


  EOH
end


bash "configure cocaine-runtime and proxy" do
  user "root"
  cwd "/vagrant/examples"
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

bash "create cocaine app control objects" do
  code <<-EOH
  
  cocaine-tool runlist list | grep -q default || {
    cocaine-tool runlist create --name default
    cocaine-tool profile upload --name default --profile='{"pool-limit": 4, "isolate": { "type": "docker" }}'
  }
  EOH
end

bash "bootstrap" do
  user "root"
  cwd "/"
  code <<-EOH
  cocaine-tool proxy start --daemon --port=80

  EOH
end
