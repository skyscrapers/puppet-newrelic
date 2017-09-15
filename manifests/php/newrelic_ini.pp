# This module should not be used directly. It is used by newrelicnew::php.
define newrelicnew::php::newrelic_ini (
  $exec_path,
  $newrelic_php_package_ensure                           = $::newrelicnew::agent::php::newrelic_php_package_ensure,
  $newrelic_php_service_ensure                           = $::newrelicnew::agent::php::newrelic_php_service_ensure,
  $newrelic_php_service_enable                           = $::newrelicnew::agent::php::newrelic_php_service_enable,
  $newrelic_php_conf_dir                                 = $::newrelicnew::agent::php::newrelic_php_conf_dir,
  $newrelic_php_exec_path                                = $::newrelicnew::agent::php::newrelic_php_exec_path,
  $newrelic_php_package                                  = $::newrelicnew::agent::php::newrelic_php_package,
  $newrelic_php_service                                  = $::newrelicnew::agent::php::newrelic_php_service,
  $newrelic_license_key                                  = $::newrelicnew::agent::php::newrelic_license_key,
  $newrelic_ini_appname                                  = $::newrelicnew::agent::php::newrelic_ini_appname,
  $newrelic_ini_browser_monitoring_auto_instrument       = $::newrelicnew::agent::php::newrelic_ini_browser_monitoring_auto_instrument,
  $newrelic_ini_enabled                                  = $::newrelicnew::agent::php::newrelic_ini_enabled,
  $newrelic_ini_error_collector_enabled                  = $::newrelicnew::agent::php::newrelic_ini_error_collector_enabled,
  $newrelic_ini_error_collector_prioritize_api_errors    = $::newrelicnew::agent::php::newrelic_ini_error_collector_prioritize_api_errors,
  $newrelic_ini_error_collector_record_database_errors   = $::newrelicnew::agent::php::newrelic_ini_error_collector_record_database_errors,
  $newrelic_ini_framework                                = $::newrelicnew::agent::php::newrelic_ini_framework,
  $newrelic_ini_high_security                            = $::newrelicnew::agent::php::newrelic_ini_high_security,
  $newrelic_ini_logfile                                  = $::newrelicnew::agent::php::newrelic_ini_logfile,
  $newrelic_ini_loglevel                                 = $::newrelicnew::agent::php::newrelic_ini_loglevel,
  $newrelic_ini_transaction_tracer_custom                = $::newrelicnew::agent::php::newrelic_ini_transaction_tracer_custom,
  $newrelic_ini_transaction_tracer_detail                = $::newrelicnew::agent::php::newrelic_ini_transaction_tracer_detail,
  $newrelic_ini_transaction_tracer_enabled               = $::newrelicnew::agent::php::newrelic_ini_transaction_tracer_enabled,
  $newrelic_ini_transaction_tracer_explain_enabled       = $::newrelicnew::agent::php::newrelic_ini_transaction_tracer_explain_enabled,
  $newrelic_ini_transaction_tracer_explain_threshold     = $::newrelicnew::agent::php::newrelic_ini_transaction_tracer_explain_threshold,
  $newrelic_ini_transaction_tracer_record_sql            = $::newrelicnew::agent::php::newrelic_ini_transaction_tracer_record_sql,
  $newrelic_ini_transaction_tracer_slow_sql              = $::newrelicnew::agent::php::newrelic_ini_transaction_tracer_slow_sql,
  $newrelic_ini_transaction_tracer_stack_trace_threshold = $::newrelicnew::agent::php::newrelic_ini_transaction_tracer_stack_trace_threshold,
  $newrelic_ini_transaction_tracer_threshold             = $::newrelicnew::agent::php::newrelic_ini_transaction_tracer_threshold,
  $newrelic_ini_capture_params                           = $::newrelicnew::agent::php::newrelic_ini_capture_params,
  $newrelic_ini_ignored_params                           = $::newrelicnew::agent::php::newrelic_ini_ignored_params,
  $newrelic_ini_webtransaction_name_files                = $::newrelicnew::agent::php::newrelic_ini_webtransaction_name_files,
  $newrelic_daemon_cfgfile_ensure                        = $::newrelicnew::agent::php::newrelic_daemon_cfgfile_ensure,
  $newrelic_daemon_dont_launch                           = $::newrelicnew::agent::php::newrelic_daemon_dont_launch,
  $newrelic_daemon_pidfile                               = $::newrelicnew::agent::php::newrelic_daemon_pidfile,
  $newrelic_daemon_location                              = $::newrelicnew::agent::php::newrelic_daemon_location,
  $newrelic_daemon_logfile                               = $::newrelicnew::agent::php::newrelic_daemon_logfile,
  $newrelic_daemon_loglevel                              = $::newrelicnew::agent::php::newrelic_daemon_loglevel,
  $newrelic_daemon_port                                  = $::newrelicnew::agent::php::newrelic_daemon_port,
  $newrelic_daemon_ssl                                   = $::newrelicnew::agent::php::newrelic_daemon_ssl,
  $newrelic_daemon_ssl_ca_bundle                         = $::newrelicnew::agent::php::newrelic_daemon_ssl_ca_bundle,
  $newrelic_daemon_ssl_ca_path                           = $::newrelicnew::agent::php::newrelic_daemon_ssl_ca_path,
  $newrelic_daemon_proxy                                 = $::newrelicnew::agent::php::newrelic_daemon_proxy,
  $newrelic_daemon_collector_host                        = $::newrelicnew::agent::php::newrelic_daemon_collector_host,
  $newrelic_daemon_auditlog                              = $::newrelicnew::agent::php::newrelic_daemon_auditlog,
) {

  exec { "/usr/bin/newrelic-install ${name}":
    path     => $exec_path,
    command  => "/usr/bin/newrelic-install purge ; NR_INSTALL_SILENT=yes, NR_INSTALL_KEY=${newrelic_license_key} /usr/bin/newrelic-install install",
    provider => 'shell',
    user     => 'root',
    group    => 'root',
    unless   => "grep ${newrelic_license_key} ${name}/20-newrelic.ini",
  }

  file { "${name}/20-newrelic.ini":
    path    => "${name}/20-newrelic.ini",
    content => template('newrelicnew/newrelic.ini.erb'),
    require => Exec["/usr/bin/newrelic-install ${name}"],
  }

  file { "${name}/newrelic.ini":
    ensure => absent,
  }

}
