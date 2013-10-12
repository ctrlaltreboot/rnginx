define :nginx_optimize do
  template "#{node[:nginx][:install_dir]}/conf/conf.d/optimize.conf" do
    source 'optimize.conf.erb'
    owner 'root'
    group 'root'
    mode 00644
    notifies :restart, 'service[nginx]', :immediately
  end
end
