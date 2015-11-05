source 'http://rubygems.org'

gem 'rails', '3.2.22'

# Bundle edge Rails instead:
# gem 'rails',     :git => 'git://github.com/rails/rails.git'

gem 'pg'
gem 'enumerate_it'
gem 'paperclip'
#gem 'aws-s3'
gem 'aws-sdk'
gem 'devise'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'
gem 'rails-i18n'
gem 'tolk'#, :git => 'git://github.com/panva/tolk.git', :branch => 'master'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# Use unicorn as the web server
# gem 'unicorn'

group :development do
  gem 'capistrano-rvm',   '~> 0.1', require: false
  gem 'capistrano', '~> 3.4.0', require: false
  gem 'capistrano-rails',   '~> 1.1', require: false
  gem 'capistrano-bundler', '~> 1.1', require: false
  gem 'capistrano-passenger', '~> 0.1.1', require: false
end


# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'

group :test do
  # Pretty printed test output
  gem 'turn', '~> 0.8.3', :require => false
end

gem 'bootstrap-generators', '~>1.0.1'
group :development do
  gem 'annotate', :git => 'git://github.com/ctran/annotate_models.git'
  gem 'byebug'
end

gem 'dotenv-rails'
gem 'rails-secrets'

gem 'test-unit', '~> 3.1' # annoyingly, rails console won't start without it in staging / production
