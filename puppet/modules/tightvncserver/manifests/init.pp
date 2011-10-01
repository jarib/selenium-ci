class tightvncserver {
  $vnc_display    = ":1"
  $vnc_passwd     = "selenium"
  $vnc_home       = "/home/vagrant/.vnc"
  $vnc_passwdfile = "$vnc_home/passwd"
  $vnc_pid        = "$vnc_home/$::hostname$vnc_display.pid"

  file { "/etc/profile.d/vnc-display.sh":
    content => "export DISPLAY=$vnc_display",
    mode => 755
  }

  package { "tightvncserver":
    ensure => present
  }

  file { "vnc-home":
     ensure => directory,
     mode   => 755,
     owner  => vagrant,
     path => "/home/vagrant/.vnc"
  }

  exec { "create-vnc-passwd":
    command   => "echo $vnc_passwd | vncpasswd -f > $vnc_passwdfile",
    path      => "/usr/bin:/usr/sbin:/bin:/usr/local/bin",
    user      => "vagrant",
    logoutput => on_failure,
    require   => File['vnc-home'],
    onlyif    => "[ ! -f $vnc_passwdfile ]"
  }

  exec { "start-vncserver":
    command     => "tightvncserver $vnc_display",
    path        => "/usr/bin:/bin",
    onlyif      => "[ ! -f \"$vnc_pid\" ] || ! ps `cat \"$vnc_pid\"` >/dev/null",
    user        => "vagrant",
    cwd         => "/home/vagrant",
    logoutput   => on_failure,
    environment => ["HOME=/home/vagrant"]
  }

  Package['tightvncserver'] -> Exec['start-vncserver']
  Exec['create-vnc-passwd'] -> Exec['start-vncserver']
}

