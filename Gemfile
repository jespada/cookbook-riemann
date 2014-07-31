source 'https://rubygems.org'

gem 'chefspec',   '~> 4'
gem 'berkshelf',  '~> 3'
gem 'rake'
gem 'rubocop'
gem 'foodcritic'

group :plugins do
  gem "vagrant-berkshelf", github: "berkshelf/vagrant-berkshelf"
  gem "vagrant-omnibus", github: "schisamo/vagrant-omnibus"
end

group :integration do
  gem 'test-kitchen'
  gem 'kitchen-vagrant'
  gem 'kitchen-docker'
end
