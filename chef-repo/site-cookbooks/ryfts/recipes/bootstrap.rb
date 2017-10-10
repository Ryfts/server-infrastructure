# create self signed certificate to start nginx successfully
# it is required to request a real certificate

users_manage 'deploy' do
end

include_recipe 'acme::default'

directory File.dirname(node['ryfts']['nginx']['ssl']['cert']) do
  recursive true
end

acme_selfsigned 'ryfts.io' do
  crt node['ryfts']['nginx']['ssl']['cert']
  key node['ryfts']['nginx']['ssl']['cert_key']
end

remote_file node['ryfts']['nginx']['ssl']['trusted_cert'] do
  source node['ryfts']['nginx']['ocsp_ca']
  owner 'deploy'
  group 'deploy'
  mode '0644'
end