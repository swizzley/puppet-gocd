# == Define: gocd::user
#
define gocd::user ($user = $title, $password = undef,) {
  validate_string($user)

  validate_string($password)
  $name_regex = '/^[a-z0-9_-]{3,16}$/'
  $name_error = "The username '${name}' is not valid."
  validate_re($name, $name_regex, $name_error)
  $password_regex = '/^\{[A-Z0-9]+\}[a-zA-Z0-9+\/]+={0,2}$/'
  $password_error = "The password hash '${password}' is not valid."
  validate_re($password, $password_regex, $password_error)

  concat::fragment { "/var/lib/go-server/passwd:${name}":
    target  => '/var/lib/go-server/passwd',
    content => "${name}:${password}",
    require => Package[$gocd::package_name]
  }

}
