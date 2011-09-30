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
}
