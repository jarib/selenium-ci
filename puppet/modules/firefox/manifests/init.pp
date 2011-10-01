class firefox {
  $url     = "http://releases.mozilla.org/pub/mozilla.org/firefox/releases/6.0.2/linux-i686/en-US/firefox-6.0.2.tar.bz2"
  $tarball = "/tools/firefox.tar.bz2"

  exec { "download-tarball":
    command => "curl -o $tarball $firefox_url",
    user => vagrant,
    path => "/usr/bin",
    require => [File['/tools'], Package['curl']]
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
