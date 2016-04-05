# == Class: gocd::common
#
class gocd::common {
  if $gocd::manage_dependencies {
    $comment = 'ThoughtWorks GoCD YUM Repository'
    $fingerprint = '9A439A18CBD07C3FF81BCE759149B0A6173454C7'
    $location = 'http://dl.bintray.com/gocd/gocd-rpm'
    $gpg_key_url = undef

    # Lookup the RPM key from the MIT PGP key server automatically.
    $default = 'https://pgp.mit.edu/pks/lookup?op=get&options=mr&search=0x%s'

    # Use the specified key URL, or construct one from the fingerprint.
    $gpgkey = pick($gpg_key_url, sprintf($default, $fingerprint))

    package { 'nss': ensure => 'latest' } ->
    class { '::java': before => Package[$gocd::package_name] }
  }

  if $gocd::manage_repository {
    if $gocd::manage_epel {
      include ::epel
    }

    yumrepo { 'thoughtworks-gocd':
      ensure   => present,
      baseurl  => $location,
      descr    => $comment,
      gpgkey   => $gpgkey,
      gpgcheck => '0',
      enabled  => '1',
    }
  }

  if $gocd::manage_user {
    create_resources('gocd::service_account', $gocd::service_user)
  }
}
