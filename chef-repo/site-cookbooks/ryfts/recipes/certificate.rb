# request real ssl certificate
acme_ssl_certificate node['ryfts']['nginx']['ssl']['cert'] do
  cn           'ryfts.io'
  alt_names    ['www.ryfts.io']
  output       :fullchain
  key          node['ryfts']['nginx']['ssl']['cert_key']
  min_validity 30 # Renew certificate if expiry is closed than this many days
  webserver    :nginx
  notifies     :reload, 'service[nginx]'
  owner        node['nginx']['user']
end