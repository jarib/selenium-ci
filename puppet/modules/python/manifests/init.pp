class python {
  package { "python-virtualenv":
    ensure => present
  }

  package { "python-pip":
    ensure => present
  }
}