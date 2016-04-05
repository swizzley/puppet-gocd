# == Class: gocd::install
#
class gocd::install {
  package { $gocd::package_name:
    ensure  => $gocd::package_ensure,
    require => [Class['gocd::common'], Class['::java']]
  }
}
