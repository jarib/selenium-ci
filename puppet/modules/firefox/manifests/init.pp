class firefox {
  $tarball = "/tools/firefox.tar.bz2"

  file { "firefox-tarball":
    mode => 644,
    ensure => file,
    source => "file:///tmp/vagrant-puppet/modules-0/firefox/files/firefox-6.0.2.tar.bz2", # not ideal
    path => $tarball
    require => File['/tools']
  }

  file { "/etc/profile.d/firefox-path.sh":
    content => 'export PATH=/tools/firefox:$PATH',
    mode => 755
  }

  exec { "install-firefox":
    cwd => "/tools",
    command => "tar jxvf firefox.tar.bz2",
    require => File['firefox-tarball'],
    path => ["/usr/bin", "/bin"],
    onlyif => "[ ! -f /tools/firefox/firefox ]"
  }

  #
  # for native events:
  #

  file { "/usr/lib/libX11.so.6":
    ensure => link,
    target => "/usr/lib/i386-linux-gnu/libX11.so.6"
  }

  package { "pkg-config":
    ensure => installed,
  }

  package { "libgtk2.0-dev":
    ensure => installed,
  }

  package { "libibus-dev":
    ensure => installed,
  }
}
