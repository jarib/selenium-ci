class xvfb {
  package { "xvfb": 
    ensure => present
  }
  
  # for screenshots
  package { "x11-apps":
    ensure => present,
  }
  
  # for screenshots
  package { "netpbm":
    ensure => present,
  }

  file { "/etc/init.d/xvfb":
    ensure => file,
    source => "file:///tmp/vagrant-puppet/modules-0/xvfb/files/init.sh", # not ideal
    mode => 755,
    owner => root
  }
  
  file { "take-screenshot.sh":
    ensure => file,
    path => "/home/vagrant/take-screenshot.sh",
    mode => 755,
    source => "file:///tmp/vagrant-puppet/modules-0/xvfb/files/take-screenshot.sh" # not ideal
  }
  
  service { "xvfb": 
    ensure => running,
    require => [Package['xvfb'], File['/etc/init.d/xvfb']]
  }
}

