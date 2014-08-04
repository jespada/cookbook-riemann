#
# Cookbook Name:: riemann
# Recipe:: default
#
# Copyright (C) 2014 Jorge Espada
#
#


include_recipe 'java::default'
include_recipe 'rbenv::default'
include_recipe 'runit::default'

rbenv_ruby node['riemann']['ruby_version'] do
  global true
end

user node['riemann']['user_name'] do
  home node['riemann']['user_home']
  shell node['riemann']['user_shell']
  system true
end

directory node['riemann']['user_home'] do
  owner node['riemann']['user_name']
  group node['riemann']['user_name']
  action :create
end

directory node['riemann']['log_dir'] do
  owner node['riemann']['user_name']
  group node['riemann']['user_name']
  mode 00755
  action :create
end

remote_file File.join(Chef::Config[:file_cache_path], node['riemann']['package']) do
  source node['riemann']['package_url']
  mode 00644
  action :create_if_missing
end

package File.join(Chef::Config[:file_cache_path], node['riemann']['package']) do
  case node['platform_family']
  when 'debian'
    provider Chef::Provider::Package::Dpkg
  when 'rhel'
    provider Chef::Provider::Package::Rpm
 # else
 #  install instruction for .tar.bz2
  end
  action :install
end

runit_service 'riemann' do
  supports :restar => true
  default_logger true
  action [:enable, :start]
end

# In case we store the config on a separate repo
if node['riemann']['conf_repo']
    git node['riemann']['conf_dir'] do
      repository node['riemann']['conf_repo']
      revision node['riemann']['git_revision']
      action :sync
      notifies :restart, 'service[riemann]'
    end
else
  template "#{node['riemann']['conf_repo']}/riemann.config" do
    source 'riemann.config.erb'
    owner node['riemann']['user_name']
    mode 0755
    variables(
              :expire_period => node['riemann']['expire_period'],
              :log_dir => node['riemann']['log_dir'],
              :tcp_listen_host => node['riemann']['tcp_listen_host'],
              :tcp_listen_port => node['riemann']['tcp_listen_port'],
              :upd_listen_host => node['riemann']['udp_listen_host'],
              :upd_listen_port => node['riemann']['udp_listen_port'],
              :graphie_host => node['riemann']['graphite_host'],
              :event_ttl => node['riemann']['event_ttl'],
              :ws_listen_host => node['riemann']['ws_listen_host'],
              :ws_listen_port => node['riemann']['ws_listen_port']
              )
    notifies :restart, 'service[riemann]'
  end
end

include_recipe 'riemann::utils'
include_recipe 'riemann::dash'
