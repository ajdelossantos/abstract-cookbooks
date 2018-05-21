service "abstract" do
  action [:stop]
end 

directory "#{node[:abstract][:path]}" do
  owner 'ubuntu'
  group 'ubuntu'
  mode '0755'
  recursive true
  action :create
end

# deploy script here
git "#{node[:abstract][:path]}" do
  repository node[:abstract][:git_repository]
  revision node[:abstract][:git_revision]
  environment ({"HOME"=>"/home/ubuntu"})
  action :sync
  user "ubuntu"
end

# Temporary workaround due to annotate gem dependency
execute "Install Rake" do
  cwd node[:abstract][:path]
  command "gem install rake -v '12.3.0' --source 'https://rubygems.org/'"
  user "ubuntu"
  # group new_resource.group
  environment ({"HOME"=>"/home/ubuntu"})
  # not_if { package_installed? }
end

execute "Install Gems" do
  cwd node[:abstract][:path]
  command "bundle install"
  user "ubuntu"
  # group new_resource.group
  environment ({"HOME"=>"/home/ubuntu"})
  # not_if { package_installed? }
end

execute "Install NPM packages" do
  cwd node[:abstract][:path]
  command "npm install"
  user "ubuntu"
  # group new_resource.group
  environment ({"HOME"=>"/home/ubuntu"})
  # not_if { package_installed? }
end

execute "Compile Webpack Assets" do
  cwd node[:abstract][:path]
  command "./node_modules/.bin/webpack"
  environment ({"NODE_ENV": "production", "HOME": "/home/ubuntu"})
  user "ubuntu"
end

execute "Clobber Rails Assets" do
  cwd node[:abstract][:path]
  command "bundle exec rake assets:clobber"
  environment ({"RAILS_ENV": "production", "HOME": "/home/ubuntu"})
  user "ubuntu"
end

execute "Compile Rails Assets" do
  cwd node[:abstract][:path]
  command "bundle exec rake assets:precompile"
  environment ({"RAILS_ENV": "production", "HOME": "/home/ubuntu"})
  user "ubuntu"
end

service "abstract" do
  action [ :enable, :start ]
end 