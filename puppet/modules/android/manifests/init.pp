class android {
  $tarball = "/tools/android-sdk.tgz"
  $sdkpath = "/tools/android-sdk-linux_x86"

  exec { "download-tarball":
    command => "curl -o $tarball http://dl.google.com/android/android-sdk_r13-linux_x86.tgz",
    user    => vagrant,
    path    => "/usr/bin",
    onlyif  => "[ ! -f $tarball ]",
    require => [File['/tools'], Package['curl']]
  }

  file { "/etc/profile.d/android-sdk-path.sh":
    content => "export PATH=$sdkpath/tools:$sdkpath/platform-tools:\$PATH",
    mode    => 755
  }

  exec { "install-android-sdk":
    cwd     => "/tools",
    user    => vagrant,
    command => "tar zxvf $tarball",
    require => Exec['download-tarball'],
    path    => ["/usr/bin", "/bin"],
    onlyif  => "[ ! -d $sdkpath ]",
    logoutput => on_failure
  }

  #
  # we need http://code.google.com/p/android/issues/detail?id=19504
  #

  # exec { "update-platforms":
  #    command   => "android update sdk --no-ui",
  #    path      => ["$sdkpath/tools", "/usr/bin", "/bin"],
  #    logoutput => on_failure
  #  }

  # TODO: generate properties.yml?

  Exec['download-tarball'] -> Exec['install-android-sdk'] #-> Exec['update-platforms']
}