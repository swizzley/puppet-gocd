# Class gocd::params
#
class gocd::params {
  $manage_dependencies = true
  $manage_repository = true
  $manage_epel = true
  $manage_user = true
  $package_ensure = 'latest'
  $service_ensure = 'running'
  $keystore_password = '53rv3rKeystorepa55w0rd'
  $service_enable = true
  $manage_service = true
  $manage_package = true
  $manage_firewall = true
  $listen_port = 8153
  $listen_port_ssl = 8154
  $manage_certs = false
  $ssl_certificate = undef
  $ssl_private_key = undef
  $ssl_ca_cert = undef
  $service_user = {
    'service_account' => {
      user    => 'gocd',
      group   => 'gocd',
      home    => '/home/gocd',
      comment => 'GoCD Service Account',
    }
  }

}
