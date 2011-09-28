class tightvncserver {
  package { "tightvncserver":
    ensure => present
  }

  file { "/home/vagrant/.vnc":
    ensure => directory,
    mode => 755,
    owner => vagrant
  }

  file { "/home/vagrant/.vnc/passwd":
    ensure => file,
    source => "file:///tmp/vagrant-puppet/modules-0/tightvncserver/files/passwd",
    mode => 600,
    owner => vagrant
  }

  file { "/home/vagrant/.vnc/xstartup":
    ensure => file,
    owner => vagrant,
    mode => 755,
    source => "file:///tmp/vagrant-puppet/modules-0/tightvncserver/files/xstartup" # not ideal
  }

  exec { "start-vncserver":
    command => "tightvncserver :1",
    path => "/usr/bin:/bin",
    onlyif => 'test ! -f "/home/vagrant/.vnc/lucid32:1.pid"',
    user => "vagrant",
    logoutput => on_failure,
    environment => ["HOME=/home/vagrant"]
  }
}

