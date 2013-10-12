#
# Cookbook Name:: rnginx
# Recipe:: default_site
#
# Copyright 2013, ctrlaltreboot@gmail.com
#
# Released Under GPL version 2
#
#
include_recipe 'rnginx::default'

template "#{node[:nginx][:install_dir]}/conf/vhosts/default.conf" do
  source 'default.conf.erb'
  owner "root"
  group "root"
  mode 00644
  notifies :restart, 'service[nginx]', :immediately
end

directory "#{node[:nginx][:default_www_dir]}" do
  owner "www-data"
  group "www-data"
  mode 00755
  recursive true
  action :create
end

cookbook_file "#{node[:nginx][:default_www_dir]}/index.html" do
  source 'index.html'
  owner "www-data"
  group "www-data"
  mode 00755
end
