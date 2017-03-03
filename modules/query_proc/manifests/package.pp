# Class: query_proc::package
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
class query_proc::package {

  # parent class must be defined
  if ! defined(Class[ '::query_proc' ]) {
    fail("${module_name} : You must declare class ${module_name} before ${module_name}::package")
  }

  # install dependencies
  package { 'python-pip':
    ensure => 'present',
    tag    => 'apt'
  }

  package { [ 'flask', 'flask-api' ]:
    provider => 'pip',
    ensure   => 'present',
    tag      => 'pip'
  }
  
  # apt must execute before pip
  Package <| tag == apt |> -> Package <| tag == pip |>
  
  # usually this would call package provider, but this is just a simple script, so copy
  # file into place
  file { '/srv/query_proc.py':
    source => "puppet:///modules/${module_name}/query_proc.py"
  }

}
