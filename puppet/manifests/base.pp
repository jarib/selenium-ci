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

include xvfb
include firefox