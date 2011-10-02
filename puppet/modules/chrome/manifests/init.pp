class chrome {
  # should use https, but not supported by GET by default
  $google_deb_key = "http://dl-ssl.google.com/linux/linux_signing_key.pub"
  $chromedriver_url = "http://commondatastorage.googleapis.com/chromium-browser-snapshots/Linux/103665/chrome-linux.test/chromedriver"

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

  exec { "download-chromedriver":
    cwd       => "/usr/bin",
    command   => "curl -L -o /usr/bin/chromedriver $chromedriver_url",
    path      => "/usr/bin",
    onlyif    => "[ ! -f /usr/bin/chromedriver ]",
    logoutput => on_failure,
    require   => [Package['curl']]
  }

  file { "/usr/bin/chromedriver":
     mode    => 755,
     ensure  => file,
     require => Exec['download-chromedriver']
   }
}

