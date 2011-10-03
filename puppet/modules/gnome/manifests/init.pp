# Class: gnome
#
# Minimal gnome install for native events
#

class gnome {
  package { "gnome-session":
    ensure => installed,
  }

  package { "metacity":
    ensure => installed,
  }
  
  file { "vnc-xstartup":
    ensure => file,
    path   => "/home/vagrant/.vnc/xstartup",
    source => "file:///tmp/vagrant-puppet/modules-0/gnome/files/xstartup.sh", # not ideal
    mode   => 755,
    owner  => vagrant
  }
  
  File['/home/vagrant/.vnc'] -> File['vnc-xstartup'] -> Exec['start-vncserver']
}