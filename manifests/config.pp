# == Class: gocd::server::config
#
class gocd::config {
  if $caller_module_name != $module_name {
    fail("Use of private class ${name} from ${caller_module_name}")
  }

  if $gocd::service_name == 'go-agent' {
    if $gocd::server == undef or $gocd::server == true {
      fail('Agents must have a valid server address declared')
    }

    file { '/etc/default/go-agent':
      ensure  => present,
      content => template("${module_name}/go-agent.default.erb"),
      mode    => '0644',
      owner   => 'go',
      group   => 'go',
    }
  } else {
    file { '/etc/default/go-server':
      ensure  => present,
      content => template("${module_name}/go-server.default.erb"),
      mode    => '0644',
    }

    concat { '/var/lib/go-server/passwd':
      ensure => present,
      mode   => '0600',
      force  => true,
      owner  => 'go',
      group  => 'go',
    }

    if $gocd::ssl_certificate != undef and $gocd::ssl_private_key != undef {
      if $gocd::manage_certs {
        file { $gocd::ssl_certificate:
          ensure => present,
          source => "puppet:///${module_name}/certificate"
        }

        file { $gocd::ssl_private_key:
          ensure => present,
          source => "puppet:///${module_name}/private_key"
        }

        if $gocd::ssl_ca_cert != undef {
          file { $gocd::ssl_ca_cert:
            ensure => present,
            source => "puppet:///${module_name}/ca_certificate"
          }
        }
      }

      java_ks { 'cruise:/etc/go/keystore':
        ensure      => latest,
        certificate => $gocd::ssl_certificate,
        private_key => $gocd::ssl_private_key,
        password    => $gocd::keystore_password,
      }

      if $gocd::ssl_ca_cert != undef {
        java_ks { 'cruise:/etc/go/truststore':
          ensure       => latest,
          certificate  => $gocd::ssl_ca_cert,
          password     => $gocd::keystore_password,
          trustcacerts => true,
        }
      }
    }

    if $gocd::manage_firewall {
      firewall { '500 Allow incoming GoCD Server Dashboard connections.':
        ensure => present,
        state  => ['NEW'],
        action => 'accept',
        chain  => 'INPUT',
        proto  => 'tcp',
        dport  => [$gocd::listen_port_ssl, $gocd::listen_port,],
      }
    }
  }
}
