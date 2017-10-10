default['ryfts']['nginx']['ssl']['cert'] = '/etc/ssl/ryfts.io/ryfts.crt.pem'
default['ryfts']['nginx']['ssl']['cert_key'] = '/etc/ssl/ryfts.io/ryfts.key.pem'
default['ryfts']['nginx']['ssl']['trusted_cert'] = '/etc/ssl/ryfts.io/ca.pem'
default['ryfts']['nginx']['ssl']['dhparam'] ='/etc/ssl/certs/dhparam.pem'
default['ryfts']['nginx']['proxy_pass'] = 'http://localhost:3000'
default['ryfts']['nginx']['server_name'] = 'ryfts.io'
default['ryfts']['nginx']['ocsp_ca'] = 'https://letsencrypt.org/certs/isrg-root-ocsp-x1.pem.txt'

default['acme']['contact'] = 'mailto:dino.lukman@gmail.com'

default['bitcoin']['variant'] = 'core'

default['nginx']['user'] = 'deploy'
default['nginx']['server_tokens'] = 'off'
default['nginx']['default_site_enabled'] = false
default['nginx']['server_names_hash_bucket_size'] = '1024'