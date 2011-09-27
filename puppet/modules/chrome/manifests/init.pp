class chrome {
  $apt_source = "http://dl.google.com/linux/chrome/deb/"
  $google_deb_key = "http://dl-ssl.google.com/linux/linux_signing_key.pub" # should use https, but not supported by GET by default

  file { "google-apt-source":
    ensure => file,
    path => "/etc/apt/sources.list.d/google.list",
    content => "deb ${apt_source} stable main"
  }
  
  exec { "add-google-deb-key":
    command => "GET ${google_deb_key} | apt-key add -",
    path => "/usr/bin:/usr/sbin:/bin:/usr/local/bin",
    onlyif => "/usr/bin/test `apt-key list | grep -F Google | wc -l` -eq 0",
  }
  
  File['google-apt-source'] -> Exec['add-google-deb-key'] -> Exec['apt-update']
  
  package { "google-chrome-unstable": 
    ensure => present
  }
  
  file { "chromedriver":
     mode => 755,
     ensure => file,
     source => "file:///tmp/vagrant-puppet/modules-0/chrome/files/chromedriver", # not ideal
     path => "/usr/bin/chromedriver"
   }
}

