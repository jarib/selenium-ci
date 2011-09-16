class firefox {
  file { "firefox-tarball":
    mode => 644,
    ensure => file,
    source => "file:///tmp/vagrant-puppet/modules-0/firefox/files/firefox-6.0.2.tar.bz2", # not ideal
    path => "/tmp/firefox.tar.bz2"
  }
  
  exec { "install-firefox": 
    cwd => "/tmp",
    command => "tar jxvf firefox.tar.bz2",
    require => File['firefox-tarball'],
    path => ["/usr/bin", "/bin"]
  }
}
