default['ruby-ng']['ruby_version'] = "2.4"
default['nodejs']['version'] = "6.10.1"
default['nodejs']['npm']['version'] = "5.2.0"
default['nginx']['default_site_enabled'] = false

default[:abstract][:git_repository] = "https://github.com/ajdelossantos/Abstract"
default[:abstract][:git_revision] = "master"
# May need to ask about this
default[:abstract][:path] = "/opt/abstract"

default[:abstract][:rails_env] = "production"
default[:abstract][:log_to_stdout] = "true"

default[:abstract][:environment] = {
  "SECRET_KEY_BASE": node[:abstract][:secret_key_base],
  "DATABASE_URL": node[:abstract][:database_url],
  "RAILS_ENV": node[:abstract][:rails_env],
  "RAILS_LOG_TO_STDOUT": node[:abstract][:log_to_stdout]
}

default[:abstract][:start_cmd] = "unicorn -E production -c /opt/unicorn.rb"