default[:nginx][:default_www_dir] = "/var/www/default"
default[:nginx][:port] = "80"
default[:nginx][:server_name] = [ "localhost", "#{node[:fqdn]}" ]
