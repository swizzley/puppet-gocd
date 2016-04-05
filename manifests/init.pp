# = $gocd::params= $gocd::params Class: gocd
#
class gocd (
  $server              = undef,
  $package_ensure      = $gocd::params::package_ensure,
  $service_ensure      = $gocd::params::service_ensure,
  $service_enable      = $gocd::params::service_enable,
  $manage_service      = $gocd::params::manage_service,
  $manage_package      = $gocd::params::manage_package,
  $manage_firewall     = $gocd::params::manage_firewall,
  $manage_dependencies = $gocd::params::manage_dependencies,
  $manage_repository   = $gocd::params::manage_repository,
  $manage_user         = $gocd::params::manage_user,
  $manage_certs        = $gocd::params::manage_certs,
  $listen_port         = $gocd::params::listen_port,
  $listen_port_ssl     = $gocd::params::listen_port_ssl,
  $ssl_certificate     = $gocd::params::ssl_certificate,
  $ssl_private_key     = $gocd::params::ssl_private_key,
  $ssl_ca_cert         = $gocd::params::ssl_ca_cert,
  $keystore_password   = $gocd::params::keystore_password,
  $service_user        = $gocd::params::service_user,) inherits ::gocd::params {
  require ::git

  if $server == undef or $server == true {
    $package_name = 'go-server'
    $service_name = 'go-server'
    $work_dir = '/var/lib/go-server'
  } else {
    $package_name = 'go-agent'
    $service_name = 'go-agent'
    $work_dir = '/var/lib/go-agent'
  }
  contain '::gocd::common'
  contain '::gocd::install'
  contain '::gocd::config'
  contain '::gocd::service'

  Class['::gocd::common'] ->
  Class['::gocd::install'] ->
  Class['::gocd::config'] ~>
  Class['::gocd::service']
}
