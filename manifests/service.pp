# == Class: gocd::service

class gocd::service {
  if $caller_module_name != $module_name {
    fail("Use of private class ${name} from ${caller_module_name}")
  }

  service { $::gocd::service_name:
    ensure     => $::gocd::service_ensure,
    enable     => $::gocd::service_enable,
    hasrestart => true,
    hasstatus  => true,
  }
}
