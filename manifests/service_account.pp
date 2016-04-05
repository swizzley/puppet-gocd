# Service Account
#
define gocd::service_account ($user, $group, $home, $comment) {
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