#
# Cookbook Name:: rnginx
# Recipe:: binary
#
#

# add nginx repo from nginx.org
apt_repository 'nginx' do
  uri           'http://nginx.org/packages/ubuntu/'
  distribution  node[:nginx][:ubuntu_dist]
  components    ['nginx']
  key           'http://nginx.org/keys/nginx_signing.key'
end

# install nginx
package 'nginx' do
  version node[:nginx][:version]
  action  :upgrade
end

service 'nginx' do
  supports status: true, restart: true, reload: true
  action [ :start, :enable ]
end
