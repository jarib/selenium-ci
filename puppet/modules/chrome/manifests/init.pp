class chrome {
  $apt_source = "http://dl.google.com/linux/chrome/deb/"
  $google_deb_key = "http://dl-ssl.google.com/linux/linux_signing_key.pub" # should use https, but not supported by GET by default
  
  # this is probably not the right way to do this.
  exec { "add-google-source":
    command => "/bin/echo 'deb ${apt_source} stable main' >> /etc/apt/sources.list",
    onlyif => "/usr/bin/test `grep -F ${apt_source} /etc/apt/sources.list | wc -l` -eq 0"
  }
  
  exec { "add-google-deb-key":
    command => "GET ${google_deb_key} | apt-key add -",
    path => "/usr/bin:/usr/sbin:/bin:/usr/local/bin",
    onlyif => "/usr/bin/test `apt-key list | grep -F Google | wc -l` -eq 0",
  }
  
  Exec['add-google-source'] -> Exec['add-google-deb-key'] -> Exec['apt-update']
  
  package { "google-chrome-unstable": 
    ensure => present,
    require => [Exec['add-google-source'], Exec['add-google-deb-key']]
  }
  
  file { "chromedriver":
     mode => 755,
     ensure => file,
     source => "file:///tmp/vagrant-puppet/modules-0/chrome/files/chromedriver", # not ideal
     path => "/usr/bin/chromedriver"
   }

}

