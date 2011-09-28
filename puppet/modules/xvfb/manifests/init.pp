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

  file { "take-screenshot.sh":
    ensure => file,
    path => "/usr/bin/take-screenshot",
    mode => 755,
    source => "file:///tmp/vagrant-puppet/modules-0/xvfb/files/take-screenshot.sh", # not ideal
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

