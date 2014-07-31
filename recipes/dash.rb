#
#
#

remote_directory node['riemann']['dashboard']['directory'] do
  source 'riemann-dash'
  owner 'riemann'
  group 'riemann'
  mode 00755
  recursive true
  action :create
end

template ::File.join(node['riemann']['dashboard']['directory'], 'config.rb') do
  owner 'riemann'
  group 'riemann'
  mode 00755
  variables(
            :port => node['riemann']['dashboard']['port'] )
  action :create
end

gem_package 'riemann-dash' do
  gem_binary '/usr/local/rbenv/shims/gem'
  action :install
end

runit_service 'riemann-dash' do
  env node['riemann']['dashboard']['env']
  default_logger true
  options(
          :envdir => "#{node['runit']['sv_dir']}/riemann-dash/env",
          :confdir => node['riemann']['dashboard']['directory'] )
  action [:enable, :start]
end
