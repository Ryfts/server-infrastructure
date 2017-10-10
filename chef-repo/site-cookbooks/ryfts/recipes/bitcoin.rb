return unless node['platform'] == 'ubuntu'

apt_repository "ethereum" do
  uri "http://ppa.launchpad.net/ethereum/ethereum/ubuntu"
  distribution node['lsb']['codename']
  components ["main"]
  keyserver "keyserver.ubuntu.com"
  key "923F6CA9"
end

apt_package 'ethereum'

include_recipe 'bitcoin::binary'

# override created configuration file
template node['bitcoin']['conf_file'] do
  owner node['bitcoin']['user']
  group node['bitcoin']['user']
  mode "0600"
  action :create_if_missing
end