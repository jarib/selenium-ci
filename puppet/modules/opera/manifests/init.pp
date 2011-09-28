class opera {
  file { "opera-apt-source":
    ensure => file,
    path => "/etc/apt/sources.list.d/opera.list",
    content => "deb http://deb.opera.com/opera/ stable non-free"
  }

  exec { "add-opera-deb-key":
    command => "GET http://deb.opera.com/archive.key | apt-key add -",
    path => "/usr/bin:/usr/sbin:/bin:/usr/local/bin",
    onlyif => "test `apt-key list | grep -F Opera | wc -l` -eq 0",
  }

  File['opera-apt-source'] -> Exec['add-opera-deb-key'] -> Exec['apt-update']
  
  # how do we get past the license agreement popup on first launch?

  package { "opera":
    ensure => present
  }
}


