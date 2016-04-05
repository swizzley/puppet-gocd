# == Class: gocd::common::dependencies
#
class gocd::common::dependencies {
  package { 'nss': ensure => 'latest' } ->
  class { '::java': before => Package[$gocd::package_name] }
}
