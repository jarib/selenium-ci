class common {
  group { "puppet":
    ensure => "present",
  }

  exec { "apt-update":
    command => "/usr/bin/apt-get update",
    onlyif  => "/bin/sh -c '[ ! -f /var/cache/apt/pkgcache.bin ] || /usr/bin/find /etc/apt/* -cnewer /var/cache/apt/pkgcache.bin | /bin/grep . > /dev/null'",
  }

  Exec["apt-update"] -> Package <| |>

  file { "/tools":
    ensure => directory,
    owner => vagrant
  }

  package { "subversion":
    ensure => present
  }

  package { "openjdk-6-jdk":
    ensure => present
  }

  package { "ffmpeg":
    ensure => present
  }

  package { "curl":
    ensure => present
  }
}
