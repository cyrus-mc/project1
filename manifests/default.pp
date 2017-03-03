class { '::query_proc':
  listen_ip => hiera('listen_ip', $::ipaddress),
  port      => hiera('port', '1404'),
  debug     => hiera('debug', 'False')
}
