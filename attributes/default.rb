#
#
#

default['riemann']['ruby_version'] = '2.1.2'
default['riemann']['user_name'] = 'riemann'
default['riemann']['user_home'] = '/home/riemann'
default['riemann']['user_shell'] = '/bin/bash'
default['riemann']['log_dir'] = '/var/log/riemann'
default['riemann']['con_dir'] = '/etc/riemann'

default['riemann']['version'] = '0.2.6'
case node['platform_family']
when 'debian'
  default['riemann']['package'] = "riemann_#{node['riemann']['version']}_all.deb"
when 'rhel'
  default['riemann']['pakcage'] = "riemann_#{node['riemann']['version']}-1.noarch.rpm"
else
  default['riemann']['pakcage'] = "riemann_#{node['riemann']['version']}.tar.bz2"
end
default['riemann']['package_url'] = "http://aphyr.com/riemann/#{node['riemann']['package']}"

default['riemann']['server']['host'] = 'localhost'
default['riemann']['server']['port'] = 5555

default['riemann']['dashboard']['enable'] = true
default['riemann']['dashboard']['port'] = 4567
default['riemann']['dashboard']['directory'] = '/opt/riemann-dash'
default['riemann']['dashboard']['env'] = {
  "PATH" => "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/local/rbenv/shims"
}

default['riemann']['conf_repo'] = nil # git@github.com:guardian/riemann-config.git
default['riemann']['git_revision'] = nil

default['riemann']['expire_period'] = 5
default['riemann']['tcp_listen_host'] = 'localhost'
default['riemann']['tcp_listen_port'] = 5555
default['riemann']['udp_listen_host'] = 'localhost'
default['riemann']['udp_listen_port'] = 5555
default['riemann']['ws_listen_host'] = 'localhost'
default['riemann']['ws_listen_port'] = 5556
default['riemann']['graphite_host'] = 'localhost'
default['riemann']['event_ttl'] = 60
