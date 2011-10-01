class chrome {
  # should use https, but not supported by GET by default
  $google_deb_key = "http://dl-ssl.google.com/linux/linux_signing_key.pub"
  $chromedriver_url = "http://chromium.googlecode.com/files/chromedriver_linux32_14.0.836.0.zip"

  file { "google-apt-source":
    ensure => file,
    path => "/etc/apt/sources.list.d/google.list",
    content => "deb http://dl.google.com/linux/chrome/deb/ stable main"
  }

  exec { "add-google-deb-key":
    command => "GET ${google_deb_key} | apt-key add -",
    path => "/usr/bin:/usr/sbin:/bin:/usr/local/bin",
    onlyif => "test `apt-key list | grep -F Google | wc -l` -eq 0",
  }

  File['google-apt-source'] -> Exec['add-google-deb-key'] -> Exec['apt-update']

  package { "google-chrome-unstable":
    ensure => present
  }

  package { "unzip":
    ensure => present,
  }

  exec { "download-chromedriver":
    cwd     => "/usr/bin"
    command => "curl $chromedriver_url | funzip > /usr/bin/chromedriver",
    path    => "/usr/bin",
    onlyif  => "[ -f /usr/bin/chromedriver ]"
  }

  file { "/usr/bin/chromedriver":
     mode    => 755,
     ensure  => file,
     require => Exec['download-chromedriver']
   }
}

