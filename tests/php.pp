# Install New Relic PHP Agent

node default {

  class { '::apache':
    mpm_module => 'prefork',
  }
  class { '::apache::mod::php': }

  class {'newrelicnew::server::linux':
    newrelic_license_key => '',
  }

  class {'newrelicnew::agent::php':
    newrelic_license_key  => '',
    newrelic_php_conf_dir => ['/etc/php5/apache2/conf.d','/etc/php5/fpm/conf.d'],
    require               => Class['Apache::mod::php'],
  }

}
