#
# Cookbook Name:: rnginx
# Recipe:: common_packages
#
# Copyright 2013, ctrlaltreboot@gmail.com
#
# Released Under GPL version 2
#
#
# download package dependencies for debian/ubuntu
ngx_pkgs = %w(libpcre3 libpcre3-dev libssl-dev)

ngx_pkgs.each { |pkg| package pkg }
