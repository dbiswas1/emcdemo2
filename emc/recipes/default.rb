#
# Cookbook Name:: emc
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

httpd_service 'default' do
	action [:create,:start]
end

#httpd_config 'default' do
#	source 'mysite.cnf.erb'
#	notifies :restart, 'httpd_service[default]'
#	action :create
#end
yum_repository 'jenkins' do
	description "jenkins repository"
	baseurl "http://pkg.jenkins-ci.org/redhat/"
	gpgkey "http://pkg.jenkins-ci.org/redhat/jenkins-ci.org.key"
	action :create
end

yum_package "jenkins" do
	action :install
	flush_cache [:before]
end

service "jenkins" do
	supports [:stop, :start, :restart]
	action [:start, :enable]
end

mysql_service 'default' do
  version '5.7'
  bind_address '0.0.0.0'
  port '3306'  
  data_dir '/data'
  initial_root_password 'Ch4ng3me'
  action [:create, :start]
end

execute 'link' do
  command "ln -s /var/run/mysql-default/mysqld.sock /var/lib/mysql/mysql.sock"
  action :run
end

