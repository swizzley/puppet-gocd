# == Class: gocd::common

class gocd::common {
  define service_account ($user, $group, $home, $comment) {
    if $title != 'service_account' {
      fail('Only 1 service account allowed')
    }
    user { $user:
      ensure  => present,
      comment => $comment,
      home    => $home,
      system  => true,
    } ->
    file { $home:
      ensure => directory,
      mode   => '0755',
      owner  => $user,
      group  => $group,
    }
  }

  if $gocd::manage_dependencies {
    contain '::gocd::common::dependencies'
  }

  if $gocd::manage_repository {
    contain '::gocd::common::repository'
  }

  if $gocd::manage_user {
    create_resources('service_account', $gocd::service_user)
  }
}
