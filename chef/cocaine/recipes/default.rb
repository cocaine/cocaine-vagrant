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

git "/tmp/cocaine-tornado-proxy" do
  repository "https://github.com/noxiouz/cocaine-TornadoProxy.git"
  reference "master"
  action :sync
end

bash "install cocaine-tornado-proxy" do
  user "root"
  cwd "/tmp/cocaine-tornado-proxy"
  code <<-EOH
  /usr/bin/python setup.py install
  EOH
end

python_pip "pillow"
python_pip "qrcode"

bash "install QR example" do
  user "root"
  cwd "/vagrant/examples/qr"
  code <<-EOH
  cocaine-tool app upload
  EOH
end

bash "bootstrap" do
  user "root"
  cwd "/"
  code <<-EOH
  cocaine-tool profile upload --name default --profile='{"pool-limit": 4}'
  cocaine-tool app start --name qr --profile default
  cocaine-tornado-proxy --port 80&
  EOH
end
