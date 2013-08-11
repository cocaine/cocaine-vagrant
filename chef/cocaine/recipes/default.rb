include_recipe "python"

apt_repository "cocaine" do
  uri "http://ppa.launchpad.net/reverbrain/testing/ubuntu"
  distribution node["lsb"]["codename"]
  components ["main"]
  keyserver "keyserver.ubuntu.com"
  key "73F7B2D9"
end

package "libcocaine-core2"
package "cocaine-runtime"

python_pip "cocaine" do
  version "0.10.6.5"
  action :install
end


# Install tornado-proxy
include_recipe "git"

git "/vagrant/cocaine-tornado-proxy" do
  repository "https://github.com/noxiouz/cocaine-TornadoProxy.git"
  reference "master"
  action :sync
end

bash "install cocaine-tornado-proxy" do
  user "root"
  cwd "/vagrant/cocaine-tornado-proxy"
  code <<-EOH
  /usr/bin/python setup.py install
  EOH
end



