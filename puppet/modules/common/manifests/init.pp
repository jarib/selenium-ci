class common {
  group { "puppet":
    ensure => "present",
  }

  exec { "apt-update":
    command => "/usr/bin/apt-get update"
  }

  Exec["apt-update"] -> Package <| |>

  package { "subversion":
    ensure => present
  }

  package { "openjdk-6-jdk":
    ensure => present
  }

  package { "ffmpeg":
    ensure => present
  }

  package { "python-virtualenv":
    ensure => present
  }

  package { "python-pip":
    ensure => present
  }

  file { "/home/vagrant/.bashrc":
    ensure => file,
    mode => 644,
    owner => vagrant,
    source => "file:///tmp/vagrant-puppet/modules-0/common/files/bashrc"
  }
}
