class firefox {
  file { "firefox-tarball":
    mode => 644,
    ensure => file,
    source => "file:///tmp/vagrant-puppet/modules-0/firefox/files/firefox-6.0.2.tar.bz2", # not ideal
    path => "/tmp/firefox.tar.bz2"
  }

  file { "/etc/profile.d/firefox-path.sh":
    content => 'export PATH=/tmp/firefox:$PATH',
    mode => 755
  }

  exec { "install-firefox":
    cwd => "/tmp",
    command => "tar jxvf firefox.tar.bz2",
    require => File['firefox-tarball'],
    path => ["/usr/bin", "/bin"],
    onlyif => "[ ! -f /tmp/firefox/firefox ]"
  }

  # for native events
  file { "/usr/lib/libX11.so.6":
    ensure => link,
    target => "/usr/lib/i386-linux-gnu/libX11.so.6"
  }
}
