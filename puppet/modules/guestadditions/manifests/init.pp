class guestadditions {
  # we don't actually run this, since the version might change, but nice to have around. 
  
  file { "install-guest-additions":
    ensure => file,
    path => "/home/vagrant/install-guest-additions",
    mode => 755,
    source => "file:///tmp/vagrant-puppet/modules-0/guestadditions/files/install-guest-additions.sh" # not ideal
  }
}