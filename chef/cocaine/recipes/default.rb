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
