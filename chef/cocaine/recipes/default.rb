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
  version "0.10.6.6"
  action :install
end

##### Examples #####
python_pip "pillow"
python_pip "qrcode"

bash "configure proxy" do
  user "root"
  cwd "/vagrant/examples"
  code <<-EOH
  mkdir /etc/cocaine
  cp cocaine-tornado-proxy.conf /etc/cocaine/cocaine-tornado-proxy.conf
  EOH
end

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
  cocaine-tool proxy start --daemon --port=80
  EOH
end
