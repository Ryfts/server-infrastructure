#
# Cookbook:: ryfts
# Recipe:: nginx
#
# Copyright:: 2017, Dino Lukman, All Rights Reserved.

ssl = node['ryfts']['nginx']['ssl']

# Create directory if not already present
directory File.dirname(ssl['dhparam']) do
  recursive true
end

# Generate new key and certificate
openssl_dhparam ssl['dhparam'] do
  key_length 2048
  action :create
end

include_recipe 'nginx::default'

nginx_site 'ryfts.io' do
  enable true
  template 'ryfts.io.erb'
  variables(
    server_name:      node['ryfts']['nginx']['server_name'],
    ssl_cert:         ssl['cert'],
    ssl_cert_key:     ssl['cert_key'],
    ssl_trusted_cert: ssl['trusted_cert'],
    ssl_dhparam:      ssl['dhparam'],
    proxy_pass:       node['ryfts']['nginx']['proxy_pass']
  )
end
