# Class: query_proc::config
# ===========================
#
# Full description of class query_proc here.
#
# Parameters
# ----------
#
# Document parameters here.
#
# * `sample parameter`
# Explanation of what this parameter affects and what it defaults to.
# e.g. "Specify one or more upstream ntp servers as an array."
#
# Variables
# ----------
#
# Here you should define a list of variables that this module would require.
#
# * `sample variable`
#  Explanation of how this variable affects the function of this class and if
#  it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#  External Node Classifier as a comma separated list of hostnames." (Note,
#  global variables should be avoided in favor of class parameters as
#  of Puppet 2.6.)
#
# Examples
# --------
#
# @example
#    class { 'query_proc':
#      servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#    }
#
# Authors
# -------
#
# Author Name <author@domain.com>
#
# Copyright
# ---------
#
# Copyright 2017 Your name here, unless otherwise noted.
#
class query_proc::config {

  # parent class must be defined
  if ! defined(Class[ '::query_proc' ]) {
    fail("${module_name} : You must declare class ${module_name} before ${module_name}::config")
  }

  # defaults
  File {
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    notify => Service[ 'query_proc' ]
  }

  # generate upstart environment file
  file { '/etc/default/query_proc':
    ensure  => 'present',
    content => template("${module_name}/query_proc.erb")
  }

  # push upstart init file
  file { '/etc/init/query_proc.conf':
    ensure => 'present',
    source => "puppet:///modules/${module_name}/query_proc.conf"
  }

}
