# == Class: newrelicnew::infrastructure
#
# [*service_ensure*]
#   State for the service. Default: running
#
# [*newrelic_license_key*]
#   License key from new relic. Required.
#
class newrelicnew::infrastructure (
  $service_ensure           = running,
  $newrelic_license_key     = undef,
  $newrelic_infra_conf_file = $newrelicnew::params::infra_conf_file,
  $display_name             = undef,
  $custom_attributes        = {},
) inherits newrelicnew::params {
  include ::newrelicnew

  if ! $newrelic_license_key {
    fail('You must specify a valid License Key.')
  }

  case $::kernel {
    'Linux': {
      contain ::newrelicnew::infrastructure::linux
    }
    'Windows': {
      contain ::newrelicnew::infrastructure::windows
    }
    default: {
      warning("Unsupported Kernel ${::kernel}")
    }
  }

  file { $newrelic_infra_conf_file:
    ensure  => file,
    content => template('newrelicnew/etc/newrelic-infra.yml.erb'),
    require => Package['newrelic-infra'],
    notify  => Service['newrelic-infra'],
  }

  service {'newrelic-infra':
    ensure  => $service_ensure,
    require => Package['newrelic-infra'],
  }
}
