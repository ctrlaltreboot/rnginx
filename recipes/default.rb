#
# Cookbook Name:: rnginx
# Recipe:: default
#
# Copyright 2013, ctrlaltreboot@gmail.com
#
# Released Under GPL version 2
#
#
# download package dependencies for debian/ubuntu
include_recipe 'rnginx::common_packages'

nginx_src = "#{node[:nginx][:download_url]}"
nginx_local_tar = "/tmp/nginx-#{node[:nginx][:version]}.tar.gz"
nginx_local_dir = "/tmp/nginx-#{node[:nginx][:version]}"
nginx_compile_flags = node[:nginx][:compile_flags].join(" ")
nginx_modules = node[:nginx][:modules].join(" ")

remote_file nginx_local_tar do
  source nginx_src
  checksum #{node[:nginx][:checksum]}
  mode 00755
  owner "root"
  group "root"
  backup false
end

bash "untar_nginx_src" do
  code <<-EOS
    tar xzf #{nginx_local_tar} -C /tmp
  EOS
  not_if { ::File.directory?(nginx_local_dir) }
end

bash "compile nginx" do
  code <<-EOS
    cd #{nginx_local_dir} && ./configure #{nginx_compile_flags} #{nginx_modules} && make && make install
  EOS
  not_if { node[:nginx][:reinstall] }
end

template "/etc/init.d/nginx" do
  source 'nginx.init.erb'
  mode 00755
  owner "root"
  group "root"
end

service "nginx" do
  provider Chef::Provider::Service::Init::Debian
  supports :status => true, :restart => true, :reload => true
  action [:enable, :start]
end

default_configs = %w(nginx.conf.default fastcgi.conf.default fastcgi_params.conf.default mime.types.default scgi_params.default uwsgi_params.default nginx.conf)
default_configs.each do |defconf|
  file "#{node[:nginx][:install_dir]}/conf/#{defconf}" do
    action :delete
    backup false
  end
end

config_dirs = %w(vhosts conf.d)
config_dirs.each do |confdir|
  directory "#{node[:nginx][:install_dir]}/conf/#{confdir}" do
    owner 'root'
    group 'root'
    mode 00644
    action :create
  end
end

template "#{node[:nginx][:install_dir]}/conf/nginx.conf" do
  source 'nginx.conf.erb'
  mode 00644
  owner "root"
  group "root"
  notifies :restart, "service[nginx]", :immediately
end
