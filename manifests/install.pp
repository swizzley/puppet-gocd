# == Class: gocd::install

class gocd::install {
  if $caller_module_name != $module_name {
    fail("Use of private class ${name} from ${caller_module_name}")
  }

  package { $gocd::package_name:
    ensure  => $gocd::package_ensure,
    require => [Class['::gocd::common::dependencies'], Class['::gocd::common::repository']]
  }
}
