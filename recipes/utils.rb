#
#
#

%w{ libxslt-dev libxml2-dev }.each do |pkg|
  package pkg do
    action :install
  end
end

%w{ riemann-client riemann-tools }.each do |gem|
  gem_package gem do
    action :install
  end
end
