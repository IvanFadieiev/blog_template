def current_directory
  File.expand_path(File.dirname(__FILE__))
end

def source_paths
  Array(super) + [current_directory]
end

# def source_paths
#   Array(super) +
#     [File.expand_path(File.dirname(__FILE__))]
# end

# Gemfile
remove_file "Gemfile"
run "touch Gemfile"
add_source 'https://rubygems.org'
ruby '2.0.0'
gem 'rails', '4.0.2'
gem 'bootstrap-sass', '2.3.2.0'
gem 'bcrypt-ruby', '3.1.2'
gem 'faker', '1.1.2'
gem 'will_paginate', '3.0.4'
gem 'bootstrap-will_paginate', '0.0.9'
gem 'sprockets', '=2.11.0'
gem 'sass-rails', '4.0.1'
gem 'uglifier', '2.1.1'
gem 'coffee-rails', '4.0.1'
gem 'jquery-rails', '3.0.4'
gem 'turbolinks', '1.1.1'
gem 'jbuilder', '1.0.2'
gem 'factory_girl_rails', '4.2.1'
gem 'pg', '0.15.1'
gem 'rails_12factor', '0.0.2'
gem "slim-rails"

gem_group :development, :test do
  gem 'sqlite3', '1.3.8'
  gem 'rspec-rails', '2.13.1'
end

gem_group :doc do
  gem 'sdoc', '0.3.20', require: false
end

# add database to gitignor
insert_into_file ".gitignore", after: "/tmp\n" do <<-RUBY
/config/database.yml
  RUBY
  end

# database.yml
inside 'config' do
  remove_file 'database.yml'
  create_file 'database.yml' do <<-EOF
default: &default
	adapter: postgresql
  encoding: unicode
  pool: 5
  host: localhost
  user: postgres_user_name
  password: postgres_user_password

development:
  <<: *default
  database: #{app_name}_development

test:
  <<: *default
  database: #{app_name}_test
  host: 192.168.59.103

production:
  <<: *default
  database: #{app_name}_production

EOF
  end
end
