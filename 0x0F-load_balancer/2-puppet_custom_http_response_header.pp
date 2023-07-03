# Define a custom fact to get the server's hostname
Facter.add(:server_hostname) do
  setcode 'hostname'
end

# Install Nginx package
package { 'nginx':
  ensure => installed,
}

# Define the Nginx configuration file
file { '/etc/nginx/sites-available/default':
  ensure  => file,
  content => "
server {
    listen 80 default_server;
    listen [::]:80 default_server;

    server_name _;

    location / {
        add_header X-Served-By $server_hostname;
        proxy_pass http://backend;
    }
}
",
  require => Package['nginx'],
}

# Enable the default Nginx site
file { '/etc/nginx/sites-enabled/default':
  ensure => link,
  target => '/etc/nginx/sites-available/default',
  notify => Service['nginx'],
  require => File['/etc/nginx/sites-available/default'],
}

# Restart Nginx to apply the changes
service { 'nginx':
  ensure => running,
  enable => true,
  require => File['/etc/nginx/sites-enabled/default'],
}

