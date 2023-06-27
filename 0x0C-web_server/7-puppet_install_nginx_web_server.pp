class nginx_server {
  package { 'nginx':
    ensure => 'installed',
  }

  file { '/etc/nginx/sites-available/default':
    ensure  => 'file',
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('nginx_server/default.erb'),
    notify  => Service['nginx'],
  }

  file { '/var/www/html/index.html':
    ensure  => 'file',
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => 'Hello World!',
  }

  service { 'nginx':
    ensure  => 'running',
    enable  => true,
    require => File['/etc/nginx/sites-available/default'],
  }
}

