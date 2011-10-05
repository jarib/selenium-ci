define firefox::install($version) {
  $url     = "http://releases.mozilla.org/pub/mozilla.org/firefox/releases/$version/linux-i686/en-US/firefox-$version.tar.bz2"
  $tarball = "/tools/firefox.tar.bz2"

  exec { "download-tarball":
    command   => "curl -L -o $tarball $url",
    creates   => $tarball,
    user      => vagrant,
    path      => "/usr/bin",
    require   => [File['/tools'], Package['curl']],
    logoutput => on_failure
  }

  file { "/etc/profile.d/firefox-path.sh":
    content => 'export PATH=/tools/firefox:$PATH',
    mode => 755
  }

  exec { "install-firefox":
    cwd       => "/tools",
    command   => "tar jxvf firefox.tar.bz2",
    require   => Exec['download-tarball'],
    path      => ["/usr/bin", "/bin"],
    creates   => "/tools/firefox/firefox",
    logoutput => on_failure
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

  package { "libc6-dev-amd64":
    ensure => installed,
  }
}
