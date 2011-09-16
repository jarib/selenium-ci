class xvfb {
  package { "xvfb": 
    ensure => present
  }

  file { "/etc/init.d/xvfb":
    ensure => file,
    source => "file:///tmp/vagrant-puppet/modules-0/xvfb/files/init.sh", # not ideal
    mode => 755,
    owner => root
  }

  service { "xvfb": 
    ensure => running,
    require => [Package['xvfb'], File['/etc/init.d/xvfb']]
  }
}

